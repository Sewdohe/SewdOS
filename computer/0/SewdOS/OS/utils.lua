
function getTermMode()
  local monitor = peripheral.find("monitor")

  if monitor == nil then
    return true
  else
    return false
  end
end

local utils = {
  getTermMode = getTermMode
}

return utils