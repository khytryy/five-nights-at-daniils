require("src.scene_manager")
require("src.ost_manager")
require("src.sfx_manager")

Globals = {}

Globals.night       = 1

Globals.scene_manager     = SceneManager:init()
Globals.ost_manager       = OstManager:init()
Globals.sfx_manager       = SFXManager:init()

Globals.version = "v1.1.0-pre-alpha"

return Globals