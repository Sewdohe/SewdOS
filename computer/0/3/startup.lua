require("devices")
local modem = peripheral.find("modem")
-- front gate control
listen_port = 15
command_port = 80
modem.open(listen_port)
debug.log("Listening port " .. listen_port)



while true do
    local event, side, channel, replyChannel, message, distance = os.pullEvent("modem_message")
    debug.log("Message: " .. tostring(message)) 
    if message == "FrontGate:toggle" then
        debug.log("toggle door and reply on channel" .. replyChannel)
        rs.setOutput("bottom", not rs.getOutput("bottom"))
          
    elseif message == "FrontGate:state" then
        debug.log("reply on channel " .. replyChannel)
        modem.transmit(command_port, listen_port, rs.getOutput("bottom"))
    end
end