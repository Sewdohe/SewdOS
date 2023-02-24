-- require("device_emu")
print("SewdOS Init...")
local op = require("SewdOS.OS")
local rendering = op.rendering

print("rendering splash \n")
rendering.startupSplash()
op.startLoop()