-- file for communicating with the airport computer
local modem = peripheral.find("modem")
local device = {}





function createDevice(listen_port, command_port, device_name)
  local listen_port = listen_port
  local reply_port = command_port
  local device_name = device_name

  modem.open(listen_port)
  modem.open(reply_port)

  function toggle()
      modem.transmit(listen_port, reply_port, device_name .. ":toggle")
      return getState()
  end

  function waitForReply()
      local event, side, channel, replyChannel, message, distance
      repeat
        event, side, channel, replyChannel, message, distance = os.pullEvent("modem_message")
      until channel == reply_port

      return message
  end

  function getState()
      modem.transmit(listen_port, reply_port, device_name .. ":state")

      local event, side, channel, replyChannel, message, distance
      repeat
        event, side, channel, replyChannel, message, distance = os.pullEvent("modem_message")
      until channel == reply_port

      return sayStatus(message)
  end

  function sayStatus(status)
    if status then
      return "Open"
    else 
      return "Closed"
    end
  end

  return { 
    toggle = toggle,
    waitForReply = waitForReply,
    getState = getState,
    sayStatus = sayStatus,
    listen_port = listen_port,
    reply_port = reply_port
  }
end

device = { 
	createDevice = createDevice
}

return device
