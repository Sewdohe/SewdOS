-- OS INIT FILE 
print("Loading libraries")
local rendering = require("SewdOS.OS.rendering")
local debug = require("SewdOS.OS.debug")

rendering.clear()

debug.log('starting OS')
function startLoop()
	draw_menu()
end

OS = {
	startupSplash = startupSplash,
	startLoop = startLoop,
	rendering = rendering
}

return OS