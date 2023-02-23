local debug = require("SewdOS.OS.debug")

debug.log("start rendering...")

debug.log("request menu data")
local data = require("SewdOS.OS.data")

-- periphemu.create("rightw", "monitor")

debug.log("init render variables")
local clickIndexes = {}
local menuStartLine = 6
local nextDraw = 0
local optionIndex = 1
local menuDrawn = false

local monitor, width, height
local screen

debug.log("searching for peripherals...")
local monitor = peripheral.find("monitor")

debug.log("determining display mode...")
local termMode
if monitor == nil then
  termMode = true
  screen = term
  width, height = term.getSize()
else
  termMode = false
  screen = peripheral.find("monitor")
  width, height = monitor.getSize()
end
debug.log("Os terminal mode: " .. tostring(termMode))

local function centerPrint(text, lineNum, color)
  local text_len = string.len(text)

  local center = width / 2

  local lineCenterPos =
      math.floor((width - text_len) / 2) + 1
  screen.setTextColor(color)

  screen.setCursorPos(
    lineCenterPos, lineNum
  )

  screen.write(text)
end


local function loadingBar(line, color, time)
  debug.log("drawing loading bar")
  local loadingString = ""
  local barGrain = 12
  local tickTime = time / barGrain
  local tickTimes = 0
  local event, id

  while (tickTimes < barGrain) do
    local timer = os.startTimer(tickTime)
    repeat
      event, id = os.pullEvent("timer")
    until id == timer

    loadingString = loadingString .. "#"
    tickTimes = tickTimes + 1

    setTextColor(color)
    centerPrint(loadingString, 8, color)
  end
end

function draw_menu()
  debug.log("starting menu draw")
  -- reset counting vars for menu redraw
  if (menuDrawn) then
    menuStartLine = 6
    nextDraw = 0
    optionIndex = 1
  end

  -- clear monitor for re-draw
  clear()

  -- draw the header
  centerPrint(
    "Control Center",
    2,
    colors.purple)
  centerPrint(
    "______________",
    3,
    colors.purple)

  debug.log("Iterating menu options")
  -- Draw the main menu
  for i, option in ipairs(data.menu) do
    -- calculate which line to draw on
    local line = menuStartLine + nextDraw
    setTextColor(colors.blue)
    setCursorPos(2, line)

    -- write option to monitor
    write(optionIndex .. ". " .. option["title"])
    setTextColor(colors.orange)
    write(tostring(option["state"]))

    --set number for next line
    nextDraw = nextDraw + 2

    -- don't update click index if menu is already drawn
    if not menuDrawn then
      -- we keep an index of clickable elements, with thier line and the index of the options
      -- it correlates with.
      table.insert(clickIndexes, { line = line, index = optionIndex })
    end

    -- iterate the optionIndex so the next line has the correct index
    optionIndex = optionIndex + 1
    draw_taskbar()
  end
  menuDrawn = true
  wait_for_input()
end

function clear()
  if termMode then
    term.clear()
  else
    monitor.clear()
  end
end

function setTextColor(color)
  if termMode then
    term.setTextColor(color)
  else
    monitor.setTextColor(color)
  end
end

function setBackgroundColor(color)
  if termMode then
    term.setBackgroundColor(color)
  else
    monitor.setBackgroundColor(color)
  end
end

function setCursorPos(x, y)
  if termMode then
    term.setCursorPos(x, y)
  else
    monitor.setCursorPos(x, y)
  end
end

function write(message)
  if termMode then
    term.write(message)
  else
    monitor.write(message)
  end
end

function startupSplash()
  debug.log("drawing splash")
  clear()

  centerPrint(
    "Welcome Sewdohe.",
    3,
    colors.green)

  centerPrint(
    "Loading OS...",
    5,
    colors.purple)

  if termMode then
    centerPrint(
      "Terminal Mode",
      7,
      colors.orange)
  else
    centerPrint(
      "Monitor Mode",
      7,
      colors.orange)
  end

  loadingBar(9, colors.blue, 2)

  clear()
end

function log(message)
  setTextColor(colors.white)
  centerPrint(message, height - 3, colors.yellow)
end

function wait_for_input()
  debug.log("listening for input")
  -- Event loop
  while true do
    -- get event data
    local e, side, cx, cy = os.pullEvent(
      termMode and "mouse_click" or "monitor_touch"
    )
    -- check for valid clicks
    for i, ci in ipairs(clickIndexes) do
      -- we check if the line number clicked relates to an entry in the click index
      -- and if it does we execute it's function
      -- then we re-draw the menu with the new data
      if (cy == ci["line"]) then
        debug.log(data.menu[ci["index"]].title)
        local new_status = data.menu[ci["index"]].func()
        data.menu[ci["index"]].state = new_status
        draw_menu()
      end
      if cy == height then
        os.reboot()
      end
    end
  end
end

function draw_taskbar()
  centerPrint("[REBOOT]", height, colors.red)
end

return {
  draw_menu = draw_menu,
  clear = clear,
  centerPrint = centerPrint,
  loadingBar = loadingBar,
  startupSplash = startupSplash,
  screen = screen,
  clickIndexes = clickIndexes,
  termMode = termMode,
  log = log
}
