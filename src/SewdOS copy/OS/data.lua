local devices = require("SewdOS.OS.devices")

local garage = devices.createDevice(70, 80, "Garage")
local airport = devices.createDevice(10, 80, "Airport")
local front_gate = devices.createDevice(15, 80, "FrontGate")
local front_door = devices.createDevice(20, 80, "FrontDoor")
local study_door = devices.createDevice(25, 80, "StudyDoor")

print("Building main menu from devices...")

local menu = {
  { 
    title = "Garage: ",
    func = garage.toggle,
    state = garage.getState()
  },
  { 
	  title = "Airport Gate: ",
	  func = airport.toggle,
	  state = airport.getState()
 },
 { 
	  title = "Front Gate: ",
	  func = front_gate.toggle,
	  state = front_gate.getState()
 },
 { 
	title = "Front Door: ",
	func = front_door.toggle,
	state = front_door.getState()
 },
 { 
	title = "Study Door: ",
	func = study_door.toggle,
	state = study_door.getState()
 }
}

print("Menu build done \n")

return {
  menu = menu
}