-- file for communicating with the garage computer
local modem = peripheral.find("modem")

modem.open(80)
outport = 70
replyport = 80

function toggle()
    modem.transmit(70, replyport, "Garage:toggle")
    return sayStatus(getState())
end

function waitForReply()
    local event, side, channel, replyChannel, message, distance
    repeat
      event, side, channel, replyChannel, message, distance = os.pullEvent("modem_message")
    until channel == replyport

    return message
end

function getState()
    modem.transmit(70, replyport, "Garage:state")

    local event, side, channel, replyChannel, message, distance
    repeat
      event, side, channel, replyChannel, message, distance = os.pullEvent("modem_message")
    until channel == replyport

    return message
end

function sayStatus(status)
	if status == true then
		return "Open"
	else 
		return "Closed"
	end
end

device = { 
	toggle = toggle,
	waitForReply = waitForReply,
	getState = getState,
	sayStatus = sayStatus
}

return device
