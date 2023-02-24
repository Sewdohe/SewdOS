-- OS INIT FILE 
print("Loading libraries")
local rendering = require("SewdOS.OS.rendering")
print("rendering module loaded!")
local debug = require("SewdOS.OS.debug")

rendering.clear()

debug.log('starting OS')

local function startLoop()
	draw_menu()
end

local OS = {
	startupSplash = startupSplash,
	startLoop = startLoop,
	rendering = rendering
}

return OS