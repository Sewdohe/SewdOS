-- file for communicating with the airport computer
local devices = {}


local function createDevice(listen_port, command_port, device_name)
  -- VARIABLES --------------------------------------------------
  local device_name = device_name
  local modem = peripheral.find("modem")
  local hasModem
  local listen_port = listen_port
  local command_port = command_port


  if modem == nil then
    hasModem = false
  else
    hasModem = true
  end

  -- print(device_name .. " has modem: " .. tostring(hasModem))


  if hasModem then
    -- print("opening ports")
    modem.open(listen_port)
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
    local loop_true = true
    -- print("getting " .. device_name .. " state")
    if hasModem then
      local timer_id = os.startTimer(1)
      while loop_true do
        modem.transmit(listen_port, command_port, device_name .. ":state")
        local eventData = {os.pullEvent()}
        local event = eventData[1]

        -- print(eventData[1])
        if event == "modem_message" then
          -- print("Modem Message")
          if eventData[4] == listen_port then
            return sayStatus(eventData[5])
          end
        else if event == "timer" then
          -- print "response time out."
          loop_true = false
          return "Bad Device"
          end
        end
      end
    else
      return "No Modem"
    end
  end


  function toggle()
    local loop_true = true
    -- print("toggle " .. device_name)
    if hasModem then
      local timer_id = os.startTimer(1)
      while loop_true do
        -- print("sending toggle packet")
        modem.transmit(listen_port, command_port, device_name .. ":toggle")
        -- print("Listening for state response")
        local eventData = {os.pullEvent()}
        local event = eventData[1]

        -- print(eventData[1])
        if event == "modem_message" then
          -- print("Modem Message")
          if eventData[4] == listen_port then
            return sayStatus(eventData[5])
          end
        else if event == "timer" then
          -- print "response time out."
          loop_true = false
          return "Bad Device"
          end
        end
      end
    else
      return "No Modem"
    end
  end

  print("Device init end -------------------------")

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