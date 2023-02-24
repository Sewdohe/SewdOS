local utils = require("SewdOS.OS.utils")

function log(message)
  termMode = utils.getTermMode()
  if utils.getTermMode then
    -- do nothing lol
  else
    debug.log(message)
  end
end

local debug = {
  log = log
}

return debug