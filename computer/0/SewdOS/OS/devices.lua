-- file for communicating with the airport computer
local devices = {}


local function createDevice(listen_port, command_port, device_name)
  -- VARIABLES --------------------------------------------------
  local listen_port = listen_port
  local reply_port = command_port
  local device_name = device_name
  local modem = peripheral.find("modem")
  local hasModem


  if modem == nil then
    hasModem = false
  else
    hasModem = true
  end

  -- print(device_name .. " has modem: " .. tostring(hasModem))


  if hasModem then
    modem.open(listen_port)
    modem.open(reply_port)
  end
 -- -----------------------------------------------------------
 -- END VARIABLES










  -- FUNCTION DECLARATIONS -------------------------------------------- FUNCTION DECLARATIONS
  local function sayStatus(status)
    if status then
      return "Open"
    else
      return "Closed"
    end
  end

  local function getState()
    local modem_response = false
    local m_event, side, channel, replyChannel, message, distance

    if(hasModem) then
      modem.transmit(listen_port, reply_port, device_name .. ":state")
    end

    local timer_id = os.startTimer(0.5)    
    repeat
      -- print('entering repeat statement')
      local event, id = os.pullEvent("timer")
      -- print("listening for modem during timer")

      if hasModem then
        m_event, side, channel, replyChannel, message, distance = os.pullEvent("modem_message")
      end

      if(m_event) then
        modem_response = true
      end
    until id == timer_id
    -- print("timer up")

    if(modem_response) then
      -- print("Data from modem \n")
      return sayStatus(message)
    else
      -- print("dummy data from OS \n")
      return "Malfunction"
    end
  end


  function toggle()
    -- print("Toggle device")
    if (hasModem) then
      modem.transmit(listen_port, reply_port, device_name .. ":toggle")
      return getState()
    else
      return getState()
    end
  end

  return {
    toggle = toggle,
    getState = getState,
    sayStatus = sayStatus,
    listen_port = listen_port,
    reply_port = reply_port
  }
end
-- END FUNCTIONS ------------------------------------- END FUNCTIONS







-- EXPORT
devices = {
  createDevice = createDevice
}

return devices
-- END EXPORT