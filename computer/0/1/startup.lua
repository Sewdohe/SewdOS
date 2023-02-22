require("devices")
local modem = peripheral.find("modem")
-- garage control
modem.open(70)
print("Listening port 70")

local listen_port = 70
local command_port = 80

while true do
    local event, side, channel, replyChannel, message, distance = os.pullEvent("modem_message")
    print("Asked for: " .. message) 
    if tostring(message) == "Garage:toggle" then
        print(rs.getOutput("bottom"))
        rs.setOutput("bottom", not rs.getOutput("bottom"))
        local state = rs.getOutput("bottom")
        print(rs.getOutput("bottom"))
        modem.transmit(command_port, listen_port, state)
    elseif message == "Garage:state" then
        local state = rs.getOutput("bottom")
        print("send inital state" .. tostring(state) .. "to channel " .. replyChannel)
        modem.transmit(command_port, listen_port, state)
    end
end
