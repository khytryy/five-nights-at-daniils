require("src.menu")
require("src.globals")
require("src.warning_screen")
require("src.night_start")


local timer = 0
local pressed = false

local menu              = Menu:init()
local warning_screen    = WarningScreen:init()

Globals.scene_manager:add(Menu:init().scene)
Globals.scene_manager:add(WarningScreen:init().scene)
Globals.scene_manager:add(NightStart:init().scene)
Globals.scene_manager:setCurrent(Enums.SCENE_WARNING)

function love.load()
    Globals.scene_manager:load()

end

function love.keyreleased(key, scancode)
    pressed = false
end

function love.keypressed(key, scancode, isrepeat)
    if key == "escape" then
        love.event.quit()
    end

    Globals.scene_manager:keypressed(key, scancode, isrepeat)
end

function love.update(dt)
    timer = timer + dt
    
    Globals.scene_manager:update(dt)
    Globals.ost_manager:play()
end

function love.draw()
    Globals.scene_manager:draw()
end

function love.quit()
    
end