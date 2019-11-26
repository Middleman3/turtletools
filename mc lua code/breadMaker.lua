-- Slot Dictionaries
craftingSlots = {14, 15, 16, 10, 11, 12, 6, 7, 8}
storageSlots = {1,2,3,4,5,9,13}

--Recipe Dictionaries
bread = {name="Bread", ["4"]="minecraft:wheat", ["5"]="minecraft:wheat", ["6"]="minecraft:wheat"}

stillCrafting = true

function start()
  while stillCrafting do
    craft(bread)
  end
end

function craft(recipe)
  say("Crafting"..recipe.name.."...")
  collect()
  if recipe == nil then
    say("Failed, nil recipe.")
    stillCrafting = false
    return false
  end
  for slotNum, itemName in pairs(recipe) do
    if slotNum ~= "name" then
    place(itemName, tonumber(slotNum))
    end
  end
  clear()
  success = turtle.craft()
  if success then
    say(recipe.name.." successfully crafted.")
  else
    say(recipe.name.." could not be crafted")
    stillCrafting = false
  end
  store()
end

function place(name, slot)
  say("Placing "..name.." in slot "..slot)
  for i=1, 7 do
    turtle.select(storageSlots[i])
    slotInfo = turtle.getItemDetail()
    if slotInfo ~= nil then
      itemName = slotInfo.name
      if name == itemName then
        say("Moving "..name.. " to  slot "..slot)
        turtle.transferTo(craftingSlots[slot], 1)
        break
      end
    end 
  end  
end

function store()
  say("Storing Items...")
  turtle.turnLeft()
  turtle.turnLeft()
  for i=1, 16 do
    turtle.drop()
  end
  turtle.turnRight()
  turtle.turnRight()
end

function clear()
  say("Preparing to craft...")
  for i=1, 7 do
    turtle.select(storageSlots[i])
    turtle.drop()
  end
end

function collect()
  say("Collecting Items...")
  for i=1, 7 do
    turtle.select(storageSlots[i])
    turtle.suck()
  end
end

function say(message)
  print(message)
end

start()
