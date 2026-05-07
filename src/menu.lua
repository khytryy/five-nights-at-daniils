require("src.assets")
require("src.enums")

require("src.globals")

Menu = {}
Menu.__index = Menu

function Menu:init()
    local self = setmetatable({}, Menu)

    self.title_info = { love.graphics.newImage(Assets["menu_title"]), 70, 170}
    self.theme      = love.audio.newSource(Assets["menu_theme"], "stream")
    self.selected   = 1
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

    local font_height = font:getHeight()
    local x = love.graphics.getWidth() / 1.4
    local y = (love.graphics.getHeight() / 2) - (font_height * 3)

    if self.selected == 1 then
        love.graphics.print("NEW GAME <-", x, y + font_height)
    else
        love.graphics.print("NEW GAME", x, y + font_height)
    end

    if self.selected == 2 then
        love.graphics.print("CONTINUE " .. tostring(Globals.night) .. " <-", x, y + font_height * 2)
    else
        love.graphics.print("CONTINUE " .. tostring(Globals.night), x, y + font_height * 2)
    end
    
    if self.selected == 3 then
        love.graphics.print("OPTIONS <-", x, y + font_height * 3)
    else
        love.graphics.print("OPTIONS", x, y + font_height * 3)
    end

    love.graphics.setNewFont(15)
end

function Menu:update()
    if not self.theme:isPlaying() then
        love.audio.play(self.theme)
    end
end

return Menu