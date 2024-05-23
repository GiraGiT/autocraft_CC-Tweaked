-- Function to shorten the name
local function shortenName(name)
  local shortName = ""
  for word in string.gmatch(name, "%w+") do
    shortName = shortName .. string.sub(word, 1, 1)
  end
  return shortName
end

while true do
  -- Getting access to peripherals
  local peripherals = peripheral.getNames()
  local monitor = peripheral.wrap("top")
  
  -- Only clear the monitor if the number of peripherals has changed
  local currentPeripherals = #peripherals
  if currentPeripherals ~= previousPeripherals then
    monitor.setTextScale(0.5)
    monitor.clear()
    previousPeripherals = currentPeripherals
  end
  
  for index, name in ipairs(peripherals) do
    local storage = peripheral.wrap(name)
    
    -- Check if the peripheral has the necessary functions
    if storage.getItemDetail and storage.getItemLimit then
      -- Getting the maximum capacity of the storage
      local total = 0
      for i = 1, storage.size() do
        total = total + storage.getItemLimit(i)
      end

      -- Getting the current number of items
      local current = 0
      for i = 1, storage.size() do
        local item = storage.getItemDetail(i)
        if item then
          current = current + item.count
        end
      end

      -- Shorten the name
      local shortName = shortenName(name)

      -- Calculate the fill ratio
      local fillRatio = current / total

      -- Create the fill bar
      local fillBarLength = 20
      local filledLength = math.floor(fillRatio * fillBarLength)

      -- Displaying information on the monitor
      monitor.setCursorPos(1, index * 2 - 1)
      monitor.setTextColor(colors.white)
      monitor.write(tostring(index) .. ". " .. shortName .. ": ")
      
      monitor.setTextColor(colors.green)
      monitor.write(string.rep(" ", filledLength))
      
      monitor.setTextColor(colors.gray)
      monitor.write(string.rep(" ", fillBarLength - filledLength))
    end
  end

  -- Sleep for 1 second
  os.sleep(1)
end