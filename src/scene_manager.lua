require("src.enums")

SceneManager = {}
SceneManager.__index = SceneManager

SceneManager.current = nil
SceneManager.scenes = {}

function SceneManager:init()
    local self = setmetatable({}, SceneManager)
    self.current = nil
    self.scenes = {}

    return self
end

---@param scene table
function SceneManager:add(scene)
   table.insert(self.scenes, scene)
end

---@param index number
function SceneManager:setCurrent(index)
    self.current = self.scenes[index]
    self.scenes[index][Enums.SCENE_LOAD]()
end

function SceneManager:draw()
    if self.current == nil then love.graphics.print("current is nil", 0, 0) return end
    
    self.current[Enums.SCENE_DRAW]()
end

---@param dt number
function SceneManager:update(dt)
    if self.current == nil then return end
    
    self.current[Enums.SCENE_UPDATE](dt)
end

function SceneManager:load()
    if self.current == nil then return end
    
    self.current[Enums.SCENE_LOAD]()
end

function SceneManager:keypressed(key, scancode, isrepeat)
    if self.current == nil then return end
    
    self.current[Enums.SCENE_KEY_CALLBACK](key, scancode, isrepeat)
end