require("src.menu")

local menu
local timer = 0
local pressed = false

function love.load()
    menu = Menu:init()
end

function love.keyreleased(key, scancode)
    pressed = false
end

function love.update(dt)
    timer = timer + dt

    if love.keyboard.isDown("escape") then
        love.event.quit(0)
    end
    
    if love.keyboard.isDown("w") and not pressed then
        pressed = true
        menu.selected = menu.selected - 1
        if menu.selected < 1 then menu.selected = 1 end

    elseif love.keyboard.isDown("s") and not pressed then
        pressed = true
        menu.selected = menu.selected + 1
        if menu.selected > 3 then menu.selected = 3 end
    end

    menu:update()
end

function love.draw()
    menu:draw()
    love.graphics.print(menu.selected, 0, 0)
end

function love.quit()
    
end