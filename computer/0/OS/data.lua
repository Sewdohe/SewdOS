local garage = require("garage")
local airport = require("airport")
local frontGate = require("FrontGate")


local menu = {
  { 
	  title = "Garage: ",
	  func = garage.toggle,
	  state = garage.sayStatus(garage.getState())
  },
  { 
	  title = "Airport Gate: ",
	  func = airport.toggle,
	  state = airport.sayStatus(airport.getState())
 },
  { 
	  title = "Front Gate: ",
	  func = frontGate.toggle,
	  state = frontGate.sayStatus(frontGate.getState())
 }
}

return {
  menu = menu
}