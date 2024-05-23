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

      -- Displaying information on the monitor
      monitor.setTextScale(0.5)
      monitor.clear()
      monitor.setCursorPos(1, 1)
      monitor.write("Maximum " .. name .. " capacity: " .. total)
      monitor.setCursorPos(1, 2)
      monitor.write("Current number of items in the " .. name .. ": " .. current)
    end
  end

  -- Sleep for 1 second
  os.sleep(1)
end