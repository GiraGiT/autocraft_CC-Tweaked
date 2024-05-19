-- Poluchaem dostup k periferiyam
local chest = peripheral.wrap("minecraft:chest_2")
local drawer = peripheral.wrap("storagedrawers:standard_drawers_1_2")
local monitor = peripheral.wrap("top")

-- Poluchaem maksimalnuyu vmestimost sunduka
local total1 = 0
local total2 = 0

for i = 1, chest.size() do
  total1 = total1 + chest.size(i)
end

for i = 1, drawer.size() do
  total2 = total2 + drawer.size(i)
end

-- Poluchaem tekuschee kolichestvo predmetov

local current1 = 0
for i = 1, chest.size() do
  local item = chest.getItemDetail(i)
  if item then
    current1 = current1 + item.count
  end
end

local current2 = 0
for i = 1, drawer.size() do
  local item = drawer.getItemDetail(i)
  if item then
    current2 = current2 + item.count
  end
end

-- Vivodim informatsiyu na monitor
monitor.clear()
monitor.setCursorPos(1, 1)
monitor.write("Maksimalnaya vmestimost sunduka: " .. total1)
monitor.setCursorPos(1, 2)
monitor.write("Текущее количество предметов в сундуке: " .. current1)
monitor.setCursorPos(1, 3)
monitor.write("Maksimalnaya vmestimost yashchika: " .. total2)
monitor.setCursorPos(1, 4)
monitor.write("Текущее количество предметов в ящике: " .. current2)



