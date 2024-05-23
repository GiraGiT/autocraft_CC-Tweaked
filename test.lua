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
  
  for _, name in ipairs(peripherals) do
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

      -- Displaying information on the monitor
      monitor.setTextScale(0.5)
      monitor.clear()
      monitor.setCursorPos(1, 1)
      monitor.write(shortName .. " max: " .. total)
      monitor.setCursorPos(1, 2)
      monitor.write(shortName .. " cur: " .. current)
    end
  end

  -- Sleep for 1 second
  os.sleep(1)
end