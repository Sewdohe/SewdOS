require("devices")
local modem = peripheral.find("modem")
-- airport control
listen_port = 10
command_port = 80
modem.open(listen_port)
print("Listening port " .. listen_port)



while true do
    local event, side, channel, replyChannel, message, distance = os.pullEvent("modem_message")
    print("Message: " .. tostring(message)) 
    if message == "Airport:toggle" then
        print("toggle door and reply on channel" .. replyChannel)
        rs.setOutput("bottom", not rs.getOutput("bottom"))
        modem.transmit(command_port, listen_port, rs.getOutput("bottom"))
    elseif message == "Airport:state" then
        print("reply on channel " .. replyChannel)
        modem.transmit(command_port, listen_port, rs.getOutput("bottom"))
    end
end