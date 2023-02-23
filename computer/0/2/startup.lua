require("devices")
local modem = peripheral.find("modem")
-- airport control
listen_port = 10
command_port = 80
modem.open(listen_port)
debug.log("Listening port " .. listen_port)



while true do
    local event, side, channel, replyChannel, message, distance = os.pullEvent("modem_message")
    debug.log("Message: " .. tostring(message)) 
    if message == "Airport:toggle" then
        debug.log("toggle door and reply on channel" .. replyChannel)
        rs.setOutput("bottom", not rs.getOutput("bottom"))
        modem.transmit(command_port, listen_port, rs.getOutput("bottom"))
    elseif message == "Airport:state" then
        debug.log("reply on channel " .. replyChannel)
        modem.transmit(command_port, listen_port, rs.getOutput("bottom"))
    end
end