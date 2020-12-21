
Player = {}

function Player:load()

	self.x = 70
	self.y = 400
	self.startX = self.x
	self.startY = self.y
	self.width = 32
	self.height = 32
	self.xVel = 0
	self.yVel = 0
	self.maxSpeed = 250
	self.acceleration = 4000
	self.friction = 3500
	self.gravity = 1500
	self.jumpAmount = -600

	self.coins = 0
	self.health = {current = 3, max = 3} 

	self.color = {
		red = 255,
		green = 255,
		blue = 255,
		speed = 3,
	}

	self.graceTime = 0
	self.graceDuration = 0.1

	self.alive = true
	self.grounded = false
	self.hasDoubleJump = true

	self.direction = "rigth"
	self.state = "idle"

	self:loadAssets()

	self.physics = {}
	self.physics.body = love.physics.newBody(World, self.x, self.y, "dynamic")
	self.physics.body:setFixedRotation(true)
	self.physics.shape = love.physics.newRectangleShape(self.animation.width, self.animation.height)
	self.physics.fixture = love.physics.newFixture(self.physics.body, self.physics.shape)
end

function Player:loadAssets()
	self.animation = {timer = 0, rate = 0.1}
	self.animation.walk = {total = 3, current = 1, img = {}}
	self.animation.idle = {total = 1, current = 1, img = {}}
	self.animation.air = {total = 1, current = 1, img = {}}

	for i=1, self.animation.walk.total do
		self.animation.walk.img[i] = love.graphics.newImage("res/man-run"..i..".png")
	end
	
	self.animation.idle.img[1] = love.graphics.newImage("res/man-stand.png")

	self.animation.air.img[1] = love.graphics.newImage("res/man-run2.png")

	self.animation.draw = self.animation.idle.img[1]
	self.animation.width = self.animation.draw:getWidth()
	self.animation.height = self.animation.draw:getHeight()
end

function Player:takeDamage(amount)
	self:tintRed()
	if self.health.current - amount > 0 then
		self.health.current = self.health.current - amount
	else
		self.health.current = 0
		self:die()
	end
	print("Player health: " .. self.health.current)
end

function Player:die()
	print("Player dies!")
	Player.alive = false
end

function Player:respawn()
	if not self.alive then
		self.physics.body:setPosition(self.startX, self.startY)
		self.health.current = self.health.max
		self.alive = true
	end
end	

function Player:tintRed()
	self.color.g = 0
	self.color.b = 0
end

function Player:incrementCoins()
	self.coins = self.coins + 1
end

function Player:update(dt)
	self:unTint(dt)
	self:respawn()
	self:setState()
	self:setDirection()
	self:animate(dt)
	self:decreaseGraceTime(dt)
	self:syncPhysics()
	self:move(dt)
	self:applyGravity(dt)
end

function Player:unTint(dt)
	self.color.red = math.min(self.color.red  + self.color.speed * dt, 1)
	self.color.green = math.min(self.color.green + self.color.speed * dt, 1)
	self.color.blue = math.min(self.color.blue + self.color.speed * dt, 1)
end

function Player:setState()
	if not self.grounded then
		self.state = "air"
	elseif self.xVel == 0 then
		self.state = "idle"
	else
		self.state = "walk"
	end
end

function Player:setDirection()
	if self.xVel < 0 then 
		self.direction = "left"
	elseif self.xVel > 0 then
		self.direction = "rigth"
	end
end

function Player:animate(dt)
	self.animation.timer = self.animation.timer + dt
	if self.animation.timer > self.animation.rate then
		self.animation.timer = 0
		self:setNewFrame()
	end
end

function Player:setNewFrame()
	local anim = self.animation[self.state]
	
	if anim.current < anim.total then
		anim.current = anim.current + 1
	else
		anim.current = 1
	end
	self.animation.draw = anim.img[anim.current]
	self.animation.width = self.animation.draw:getWidth()
	self.animation.height = self.animation.draw:getHeight()
end

function Player:decreaseGraceTime(dt)
	if self.grounded then
		self.graceTime = self.graceTime - dt
	end
end

function Player:move(dt)
	if love.keyboard.isDown("d", "right") then
		self.xVel = math.min(self.xVel + self.acceleration * dt, self.maxSpeed)
	elseif love.keyboard.isDown("a", "left") then
		self.xVel = math.max(self.xVel - self.acceleration * dt, -self.maxSpeed)
	else
		self:applyFriction(dt)
	end
end

function Player:applyGravity(dt)
	if not self.grounded then
		self.yVel = self.yVel + self.gravity * dt
	end
end	

function Player:applyFriction(dt)
	self.xVel = math.max(self.xVel - self.friction * dt, 0)
	self.xVel = math.min(self.xVel + self.friction * dt, 0)
end

function Player:syncPhysics()
	self.x, self.y = self.physics.body:getPosition()
	self.physics.body:setLinearVelocity(self.xVel, self.yVel)
	self.physics.shape = love.physics.newRectangleShape(self.animation.width, self.animation.height)
end

function Player:beginContact(a, b, collision)
	
	if self.grounded then return end
	
	local nx, ny = collision:getNormal()
	if a == self.physics.fixture then
		if ny > 0 then
			self:land(collision)
		elseif ny < 0 then
			self.yVel = 0
		end
	elseif b == self.physics.fixture then
		if ny < 0 then
			self:land(collision)
		elseif ny > 0 then
			self.yVel = 0
		end
	end
end

function Player:land(collision)
	self.currentGroundCollision = collision
	self.yVel = 0
	self.grounded = true
	self.hasDoubleJump = true
	self.graceTime = self.graceDuration
end

function Player:jump(key)
	if key == "k" then 
		if self.grounded or self.graceTime > 0 then
			self.yVel = self.jumpAmount
			self.grounded = false
			self.graceTime = 0
		elseif self.hasDoubleJump then 
			self.yVel = self.jumpAmount * 0.5
			self.hasDoubleJump = false
		end
	end
end

function Player:endContact(a, b, collision)
	if a == self.physics.fixture or b == self.physics.fixture then
		if self.currentGroundCollision == collision then
			self.grounded = false
		end	
	end
end

function Player:draw()
	local scaleX = 1
	if self.direction == "left" then
		scaleX = -1
	end

	love.graphics.setColor(self.color.red, self.color.green, self.color.blue)
	love.graphics.draw(self.animation.draw, self.x, self.y, 0, scaleX, 1, self.animation.width / 2, self.animation.height / 2)
	love.graphics.setColor(255, 255, 255, 255)

end
