require("player")
require("coin")
require("spike")
local GUI = require("gui")

local STI = require("sti")


function love.load()

	scenes = {}

	scenes[1] = STI("maps/Scene-1.lua", {"box2d"})
	World = love.physics.newWorld(0, 0)
	World:setCallbacks(beginContact, endContact)
	scenes[1]:box2d_init(World)

	Player:load()
	GUI:load()

	Coin.new(350, 290)
	Coin.new(300, 290)
	Coin.new(500, 410)

	Spike.new(600, 416)
end

function love.update(dt)

	World:update(dt)
	Player:update(dt)
	GUI:update(dt)
	Coin:updateAll(dt)
	Spike:updateAll(dt)

end

function love.draw()
	
	love.graphics.setBackgroundColor(10, 100, 255)
	scenes[1]:draw(0, 0, 1, 1)

	love.graphics.push()

	Spike:drawAll()

	Coin:drawAll()

	Player:draw()

	love.graphics.pop()

	GUI:draw()

end

function love.keypressed(key)
	Player:jump(key)
end

function beginContact(a, b, collision)
	if Coin.beginContact(a, b, collision) then return end
	if Spike.beginContact(a, b, collision) then return end
	Player:beginContact(a, b, collision)
end

function endContact(a, b, collision)
	Player:endContact(a, b, collision)	
end
