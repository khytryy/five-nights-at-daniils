require("src.assets")
require("src.enums")

Menu = {}
Menu.__index = Menu

function Menu:init()
    local self = setmetatable({}, Menu)

    self.title_info = { love.graphics.newImage(Assets["menu_title"]), 0, 0 }
    return self
end

function Menu:draw()
    -- Draw the title
    love.graphics.draw( self.title_info[Enums.TEXTURE], 
                        self.title_info[Enums.X], 
                        self.title_info[Enums.Y])
end

function Menu:update()

end

return Menu