
local GUI = {}

function GUI:load()
	self.font = love.graphics.newFont("res/Kenney_Pixel.ttf", 36)

	self.coins = {}
	self.coins.img = love.graphics.newImage("res/coin.png")
	self.coins.width = self.coins.img:getWidth()
	self.coins.height = self.coins.img:getHeight()
	self.coins.scaleX = 1.5
	self.coins.scaleY = 1.5
	self.coins.x = love.graphics.getWidth() - 100 + self.coins.width / 2
	self.coins.y = 43

	self.hearts = {}
	self.hearts.img = love.graphics.newImage("res/heart.png")
	self.hearts.width = self.hearts.img:getWidth() 
	self.hearts.height = self.hearts.img:getHeight()
	self.hearts.x = 0 
	self.hearts.y = 30
	self.hearts.scale = 1
	self.hearts.offsetY = 0
	self.hearts.spacing = self.hearts.width * self.hearts.scale + 10
end

function GUI:update(dt)
	self:animateHearts(dt)
	self:animateCoins(dt)
end

function GUI:draw()
		
	self:displayHearts()

	self:displayCoins()
	self:displayCoinText()
end

function GUI:animateHearts(dt)
	self.hearts.offsetY = math.sin(love.timer.getTime() * 4)
end

function GUI:displayHearts()
	for i=1 , Player.health.current do
		local x = self.hearts.x + self.hearts.spacing * i
		love.graphics.setColor(0,0,0,126)
		love.graphics.draw(self.hearts.img, x , self.hearts.y + self.hearts.offsetY, 0, self.hearts.scale, self.hearts.scale)
		love.graphics.setColor(255, 255, 255, 255)
		love.graphics.draw(self.hearts.img, x - 3, self.hearts.y + self.hearts.offsetY - 3, 0, self.hearts.scale, self.hearts.scale)
	end
end

function GUI:animateCoins(dt)
	self.coins.scaleX = math.sin(love.timer.getTime() * 0.8) + self.coins.scaleX * 0.5
end

function GUI:displayCoins()
	love.graphics.setColor(0,0,0,126)
	love.graphics.draw(self.coins.img, self.coins.x + 3, self.coins.y + 3, 0, self.coins.scaleX, self.coins.scaleY, self.coins.width / 2, self.coins.height / 2)
	love.graphics.setColor(255, 255, 255, 255)
	love.graphics.draw(self.coins.img, self.coins.x, self.coins.y, 0, self.coins.scaleX, self.coins.scaleY, self.coins.width / 2, self.coins.height / 2)
end

function GUI:displayCoinText()
	love.graphics.setFont(self.font)
	local x = self.coins.x + self.coins.width * 1.5 / 2
	local y = self.coins.y - self.font:getHeight() / 2

	love.graphics.setColor(0,0,0,126)
	love.graphics.print(" : "..Player.coins, x + 2, y + 3)	
	love.graphics.setColor(255, 255, 255, 255)
	love.graphics.print(" : "..Player.coins, x, y)
end

return GUI