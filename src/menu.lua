require("src.asset_paths")

Menu = {}
Menu.__index = Menu

function Menu.init()
    local self = setmetatable({}, Menu)

    self.title_texture = love.graphics.newImage(AssetPaths["menu_title"])
end

function Menu:draw()
    
end

return Menu