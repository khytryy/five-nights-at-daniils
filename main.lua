require("src.menu")

local menu
local timer = 0

function love.load()
    menu = Menu:init()
end

function love.update(dt)
    timer = timer + dt

    if love.keyboard.isDown("escape") then
        love.event.quit(0)
    end

    menu:update()
end

function love.draw()
    menu:draw()
    love.graphics.print(timer, 0, 0)
end

function love.quit()
    
end