require("src.assets")
require("src.enums")

require("src.globals")

Menu = {}
Menu.__index = Menu

function Menu:init()
    local self = setmetatable({}, Menu)

    self.option_selected = 1

    self.scene = {
        [Enums.SCENE_DRAW]              = function()            self:draw()                 end,
        [Enums.SCENE_UPDATE]            = function(dt)          self:update(dt)             end,
        [Enums.SCENE_LOAD]              = function()            self:load()                 end,
        [Enums.SCENE_KEY_CALLBACK]      = function(k, sc, r)    self:keypressed(k, sc, r)   end
    }
    return self
end

function Menu:load()
    local screen_width  = love.graphics.getWidth()
    local screen_height = love.graphics.getHeight()

    self.title_info     = { love.graphics.newImage(Assets["menu_title"]),   70, 170 }

    local tip_tex       = love.graphics.newImage(Assets["tip_menu_keys"])
    local tw, th        = tip_tex:getDimensions()
    
    local tip_x         = screen_width - tw * 0.3
    local tip_y         = screen_height - th * 0.3
    self.tip_info       = { tip_tex, tip_x, tip_y }

    local daniil_tex    = love.graphics.newImage(Assets["daniil_menu_1"])

    local dw, dh        = daniil_tex:getDimensions()

    local daniil_x      = screen_width - dw * 2.5 -- We scale the image by 2.5 when we draw it, so we have to multiply by 2.5
    local daniil_y      = (screen_height / 2.5) - dh

    local daniil_1 = { daniil_tex, daniil_x, daniil_y }

    local daniil_tex2   = love.graphics.newImage(Assets["daniil_menu_2"])
    local dw2, dh2      = daniil_tex2:getDimensions()
    local daniil_x2     = screen_width - dw2 * 2.5
    local daniil_y2     = (screen_height / 2.5) - dh2

    local daniil_2 = { daniil_tex2, daniil_x2, daniil_y2 }

    self.daniil_info    = { daniil_1, daniil_2 }

    -- Load the main menu music
    self.theme = love.audio.newSource(Assets["menu_theme"], "stream")

    Globals.ost_manager:add(self.theme)
    Globals.ost_manager:setCurrent(1)

    local static_1 = { love.graphics.newImage(Assets["static_1"]), 0, 0 }
    local static_2 = { love.graphics.newImage(Assets["static_2"]), 0, 0 }
    local static_3 = { love.graphics.newImage(Assets["static_3"]), 0, 0 }
    local static_4 = { love.graphics.newImage(Assets["static_4"]), 0, 0 }
    local static_5 = { love.graphics.newImage(Assets["static_5"]), 0, 0 }

    self.static_info    = { static_1, static_2, static_3, static_4, static_5 }

    self.font = love.graphics.newFont(Assets["iom-bold"], 30)

    self.daniil_variant = 1
    self.daniil_timer   = 0

    self.daniil_switch_cooldown = math.random(1, 2)

    self.show_tip           = false
    self.tip_toggle         = false
    self.tip_timer          = 0
    self.tip_flash_timer    = 0

    self.fade       = false
    self.fade_timer = 0
end

function Menu:draw()
    if self.fade then
        love.graphics.setColor(1, 1, 1, 0.5 - self.fade_timer / 3)
    else
        love.graphics.setColor(1, 1, 1, 0.5)
    end

    if self.show_tip and self.tip_toggle then
        love.graphics.draw( self.tip_info[Enums.TEXTURE],
                            self.tip_info[Enums.X],
                            self.tip_info[Enums.Y], 0, 0.3, 0.3)
    end
    -- Draw the title
    love.graphics.draw( self.title_info[Enums.TEXTURE], 
                        self.title_info[Enums.X], 
                        self.title_info[Enums.Y], 0, 0.5, 0.5)

    -- Draw daniil
    love.graphics.draw( self.daniil_info[self.daniil_variant][Enums.TEXTURE],
                        self.daniil_info[self.daniil_variant][Enums.X],
                        self.daniil_info[self.daniil_variant][Enums.Y], 0, 2.5, 2.5)

    -- Draw the buttons
    love.graphics.setFont(self.font)

    local font_height = self.font:getHeight()
    local x = love.graphics.getWidth() / 1.4
    local y = (love.graphics.getHeight() / 2) - (font_height * 4)

    if self.option_selected == 1 then
        love.graphics.print("NEW GAME <-", x, y + font_height)
    else
        love.graphics.print("NEW GAME", x, y + font_height)
    end

    if self.option_selected == 2 then
        love.graphics.print("CONTINUE " .. tostring(Globals.night) .. " <-", x, y + font_height * 2)
    else
        love.graphics.print("CONTINUE " .. tostring(Globals.night), x, y + font_height * 2)
    end
    
    if self.option_selected == 3 then
        love.graphics.print("OPTIONS <-", x, y + font_height * 3)
    else
        love.graphics.print("OPTIONS", x, y + font_height * 3)
    end

    if self.option_selected == 4 then
        love.graphics.print("QUIT <-", x, y + font_height * 4)
    else
        love.graphics.print("QUIT", x, y + font_height * 4)
    end

    -- Draw the version
    local screen_width  = love.graphics.getWidth()
    local screen_height = love.graphics.getHeight()

    love.graphics.print(Globals.version, 0, screen_height - font_height)

    -- Draw the camera static
    local rand = math.random(1, 5)
    local s    = self.static_info[rand]

    local sw, sh = s[Enums.TEXTURE]:getDimensions()

    local scale_w = screen_width / sw
    local scale_h = screen_height / sh

    if self.fade then
        love.graphics.setColor(1, 1, 1, 0.5 - self.fade_timer / 3)
    else
        love.graphics.setColor(1, 1, 1, 0.7)
    end
    love.graphics.draw( s[Enums.TEXTURE],
                        s[Enums.X],
                        s[Enums.Y],
                        0, scale_w, scale_h)
    love.graphics.setColor(1, 1, 1, 1)

    -- Reset the font to default after use
    love.graphics.setNewFont(15)
end

---@param dt number
function Menu:update(dt)
    self.daniil_timer = self.daniil_timer + dt
    self.tip_timer = self.tip_timer + dt

    if self.daniil_variant == 1 then
        if self.daniil_timer >= self.daniil_switch_cooldown then
            self.daniil_variant     = 2
            self.daniil_timer       = 0
            self.daniil_duration    = math.random(1, 10) * 0.1
        end
    else
        if self.daniil_timer >= self.daniil_duration then
            self.daniil_variant     = 1
            self.daniil_timer       = 0
            self.daniil_duration    = math.random(1, 2)
        end
    end

    if self.tip_timer >= 10 then
        self.show_tip = true
    end

    if self.show_tip then
        self.tip_flash_timer = self.tip_flash_timer + dt
    end

    if self.tip_flash_timer >= 0.5 then
        self.tip_toggle = not self.tip_toggle
        self.tip_flash_timer = 0
    end

    if self.fade then
        self.fade_timer = self.fade_timer + dt
    end

    if self.fade and self.fade_timer >= 3 then
        if self.option_selected == Enums.MENU_QUIT then
            love.event.quit()
        elseif self.option_selected == Enums.MENU_NEW_GAME then
            Globals.night = 1
            Globals.scene_manager:setCurrent(Enums.SCENE_NIGHT_START)
        end
        self.fade_timer  = 0
        self.fade        = false
    end
end

function Menu:keypressed(key, scancode, isrepeat)
    if key == "w" then
        self.option_selected = self.option_selected - 1

        self.tip_timer  = 0
        self.show_tip   = false

        if self.option_selected < 1 then self.option_selected = 1 end
    elseif key == "s" then
        self.option_selected = self.option_selected + 1

        self.tip_timer  = 0
        self.show_tip   = false

        if self.option_selected > 4 then self.option_selected = 4 end
    elseif key == "return" then
        self.tip_timer  = 0
        self.show_tip   = false

        if self.option_selected == Enums.MENU_NEW_GAME then
            self.fade = true
        elseif self.option_selected == Enums.MENU_CONTINUE then
            self.fade = true
        elseif self.option_selected == Enums.MENU_QUIT then
            self.fade = true
        end
    end
end

return Menu