fuelTypes = {"minecraft:lava_bucket", "minecraft:coal", "IC2:itemScrap"}

function getInventory()
  tmp = turtle.getSelectedSLots()
  inventory = {}
  for i=1, 16  do 
    turtle.select(i)
    slotInfo = turtle.getItemDetail()
    if slotInfo ~= nil then 
      name = slotInfo["name"]
      count = slotInfo.count
      if inventory[name] == nil then
        inventory[name] = count
      else
        inventory[name] = inventory[name] + count
      end
    end

  end
  turtle.select(tmp)
  return inventory 
end
function imHolding(itemID)
  slotInfo = turtle.getItemDetail()
  if slotInfo ~= nil then
    itemName = slotInfo["name"]
    return itemID == itemName
  end
end
function slotList()
  tmp = turtle.getSelectedSLots()
  inv = {}
  for i=1, 16 do
    turtle.select(i)
    slotInfo = turtle.getItemDetail()
    if slotInfo ~= nil then
      itemName = slotInfo["name"]
      inv[i] = itemName..": "..turtle.getItemCount()
    else
      inv[i] = "Empty"
    end
  end
  turtle.select(tmp)
  return inv
end

-- the two following methods return the index of the previously selected slot
function findMy(itemID)
  if imHolding(itemID) then return end
  tmp = turtle.getSelectedSLots()
  for i=1, 16 do
    turtle.select(i)
    if imHolding(itemID) then return tmp end
  end
  turtle.select(tmp)
  return -1
end
function findAny(itemIDs)
  for i, itemID in ipairs(itemIDs) do
    index = findMy(itemID)
    if index > 0 then return index end
  end
  return -1
end

function refuel()
  tmp = turtle.getSelectedSlots()
  index = findMy(fuelTypes)
  if index == -1 then return false end
  turtle.select(index)
  turtle.refuel(1)
  turtle.select(tmp)
end