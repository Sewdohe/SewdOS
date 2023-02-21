require("devices")
local modem = peripheral.find("modem")
-- garage control
modem.open(70)
print("Listening port 70")

listen_port = 70
command_port = 80

while true do
    local event, side, channel, replyChannel, message, distance = os.pullEvent("modem_message")
    print("Asked for: " .. tostring(message)) 
    if message == "Garage:toggle" then
        rs.setOutput("bottom", not rs.getOutput("bottom"))
        local state = rs.getOutput("bottom")
        modem.transmit(command_port, listen_port, state)
    elseif message == "Garage:state" then
        local state = rs.getOutput("bottom")
        print("send inital state" .. tostring(state) .. "to channel " .. replyChannel)
        modem.transmit(command_port, listen_port, state)
    end
end
