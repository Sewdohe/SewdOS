-- require("device_emu")
print("SewdOS Init...")
local op = require("SewdOS.OS")
local rendering = op.rendering

rendering.startupSplash()
op.startLoop()