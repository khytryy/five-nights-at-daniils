require("src.enums")
require("src.globals")

require("src.menu")

WarningScreen = {}
WarningScreen.__index = WarningScreen

function WarningScreen:init()
    local self = setmetatable({}, WarningScreen)

    self.scene = {
        [Enums.SCENE_DRAW]          = function ()           self:draw()                 end,
        [Enums.SCENE_LOAD]          = function ()           self:load()                 end,
        [Enums.SCENE_KEY_CALLBACK]  = function (k, sc, r)   return                      end,
        [Enums.SCENE_UPDATE]        = function (dt)         self:update(dt)             end
    }

    self.fade_in_timer  = 0
    self.fade_out_timer = 0
    self.delay_timer    = 0
    self.start_delay    = false
    self.fade_out       = false

    return self
end

function WarningScreen:load()
    self.font = love.graphics.newFont(Assets["iom-bold"], 20)
end

function WarningScreen:update(dt)
    if self.fade_out then
        self.fade_out_timer = self.fade_out_timer + dt

        if self.fade_out_timer >= 2 then
            Globals.scene_manager:setCurrent(Enums.SCENE_MENU)
        end
    elseif self.start_delay then
        self.delay_timer = self.delay_timer + dt

        if self.delay_timer >= 2 then
            self.fade_out = true
        end
    else
        self.fade_in_timer = self.fade_in_timer + dt

        if self.fade_in_timer / 2 >= 0.9 then
            self.start_delay = true
        end
    end
end

function WarningScreen:draw()
    if self.fade_out then
        love.graphics.setColor(1, 1, 1, 0.9 - self.fade_out_timer / 2)
    else
        love.graphics.setColor(1, 1, 1, 0.1 + self.fade_in_timer / 2)
    end

    love.graphics.setFont(self.font)

    local font_h        = self.font:getHeight()
    local screen_width  = love.graphics.getWidth()
    local screen_height = love.graphics.getHeight()

    love.graphics.printf("WARNING!",
        0, (screen_height / 2) - font_h,
        screen_width, "center")

    love.graphics.printf("This game contains flashing lights and jumpscares! Proceed at your own risk.",
        0, (screen_height / 2) + font_h,
        screen_width, "center")
    love.graphics.newFont(13)
end