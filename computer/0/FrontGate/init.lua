-- file for communicating with the Front Gate computer
local modem = peripheral.find("modem")
modem.open(80)
modem.open(15)
outport = 15 -- gate pc listen port
replyport = 80

function toggle()
    modem.transmit(outport, replyport, "FrontGate:toggle")
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
    modem.transmit(outport, replyport, "FrontGate:state")

    local event, side, channel, replyChannel, message, distance
    repeat
      event, side, channel, replyChannel, message, distance = os.pullEvent("modem_message")
    until channel == replyport

    return message
end

function sayStatus(status)
	if status then
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
