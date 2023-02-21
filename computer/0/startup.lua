require("device_emu")
local os = require("OS")
local rendering = require("OS.rendering")

rendering.startupSplash()
os.startLoop()
os.wait_for_input()