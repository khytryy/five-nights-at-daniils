require("src.assets")
require("src.enums")

Menu = {}
Menu.__index = Menu

function Menu:init()
    local self = setmetatable({}, Menu)

    self.title_info = { love.graphics.newImage(Assets["menu_title"]), 70, 170}
    self.theme      = love.audio.newSource(Assets["menu_theme"], "stream")
    return self
end

function Menu:draw()
    -- Draw the title
    love.graphics.draw( self.title_info[Enums.TEXTURE], 
                        self.title_info[Enums.X], 
                        self.title_info[Enums.Y], 0, 0.5, 0.5)

    -- Draw the buttons
    local font = love.graphics.newFont(Assets["iom-bold"], 30)
    love.graphics.setFont(font)

    love.graphics.print("NEW GAME", 1200, 313)
    love.graphics.print("CONTINUE", 1200, 363)
    love.graphics.print("OPTIONS", 1200, 413)
    love.graphics.setNewFont(15)
end

function Menu:update()
    if not self.theme:isPlaying() then
        love.audio.play(self.theme)
    end
end

return Menu