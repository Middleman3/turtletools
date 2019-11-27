fuelTypes = {"minecraft:lava_bucket", "minecraft:coal", "ic2:itemScrap"}

function identify(index)
  return turtle.getItemDetail().name
end

function getInventory()
  local tmp = turtle.getSelectedSlot()
  local inventory = {}
  for i=1, 16  do 
    turtle.select(i)
    local slotInfo = turtle.getItemDetail()
    if slotInfo ~= nil then
      local name = slotInfo["name"]
      local count = slotInfo.count
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
  local slotInfo = turtle.getItemDetail()
  if slotInfo ~= nil then
    local itemName = slotInfo["name"]
    return itemID == itemName
  end
end
function slotList()
  local tmp = turtle.getSelectedSlot()
  local inv = {}
  for i=1, 16 do
    turtle.select(i)
    local slotInfo = turtle.getItemDetail()
    if slotInfo ~= nil then
      local itemName = slotInfo["name"]
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
  local tmp = turtle.getSelectedSlot()
  if imHolding(itemID) then return tmp end
  for i=1, 16 do
    turtle.select(i)
    if imHolding(itemID) then return i end
  end
  turtle.select(tmp)
  return -1
end
function findAny(itemIDs)
  for i, itemID in ipairs(itemIDs) do
    local index = findMy(itemID)
    if index > 0 then return index end
  end
  return -1
end

function refuel()
  local tmp = turtle.getSelectedSlot()
  local index = findAny(fuelTypes)
  if index == -1 then return false, "Out of fuel" end
  turtle.select(index)
  turtle.refuel(1)
  turtle.select(tmp)
  return true
end