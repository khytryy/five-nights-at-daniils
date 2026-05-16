require("src.globals")

NightStart = {}
NightStart.__index = NightStart

function NightStart:init()
    local self = setmetatable({}, NightStart)

    self.scene = {
        [Enums.SCENE_DRAW]              = function()            self:draw()                 end,
        [Enums.SCENE_UPDATE]            = function(dt)          self:update(dt)             end,
        [Enums.SCENE_LOAD]              = function()            self:load()                 end,
        [Enums.SCENE_KEY_CALLBACK]      = function(k, sc, r)    return                      end
    }

    self.timer = 0
    self.sound_played = false

    return self
end

function NightStart:draw()
    love.graphics.setFont(self.font)

    local screen_width  = love.graphics.getWidth()
    local screen_height = love.graphics.getHeight()

    local text_w = self.font:getWidth("NIGHT " .. Globals.night)

    love.graphics.print("NIGHT " .. Globals.night, (screen_width / 2) - (text_w / 2), (screen_height / 2) - (self.font:getHeight() / 2))

    love.graphics.newFont(13)
end

function NightStart:update(dt)
    if not self.sound_played then
        self.sound_played = not self.sound_played

        Globals.sfx_manager:add(self.sound)
        Globals.sfx_manager:setCurrent(1)
        Globals.sfx_manager:play()
    end

    self.timer = self.timer + dt

    if self.timer >= 6 then
        Globals.scene_manager:setCurrent(Enums.SCENE_WARNING)
    end
end

function NightStart:load()
    Globals.ost_manager:stop()
    self.sound = love.audio.newSource(Assets["night_start"], "stream")

    self.font = love.graphics.newFont(Assets["iom-bold"], 30)
end