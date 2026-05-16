SFXManager = {}
SFXManager.__index = SFXManager

function SFXManager:init()
    self = setmetatable({}, SFXManager)

    self.current    = nil
    self.sfxs       = {}

    return self
end

---@param sfx love.Source
function SFXManager:add(sfx)
    table.insert(self.sfxs, sfx)
end

---@param index number
function SFXManager:setCurrent(index)
    self.current = self.sfxs[index]
end

function SFXManager:play()
    love.audio.play(self.current)
end

function SFXManager:stop()
    love.audio.stop(self.current)
end