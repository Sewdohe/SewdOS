-- OS INIT FILE 
local rendering = require("OS.rendering")

rendering.clear()

function startLoop()
	draw_menu()
end

return {
	startupSplash = startupSplash,
	startLoop = startLoop,
}
