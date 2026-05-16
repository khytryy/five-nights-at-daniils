OstManager = {}
OstManager.__index = OstManager

function OstManager:init()
    local self = setmetatable({}, OstManager)

    self.current    = nil
    self.tracks     = {}

    self.playing    = false

    return self
end

---@param track love.Source
function OstManager:add(track)
    table.insert(self.tracks, track)
end

---@param index number
function OstManager:setCurrent(index)
    self.current = self.tracks[index]
end

function OstManager:play()
    if self.current and not self.playing then
        self.current:setLooping(true)
        love.audio.play(self.current)
        self.playing = true
    end
end

function OstManager:stop()
    love.audio.stop(self.current)
end