--os.loadAPI("inventory")
os.loadAPI("itemID")
rowSize = 8
length = 9
rowCount = 5
crop = itemID.wheat
seeds = itemID.seeds


function start()
  turtle.up()
  for i=1, rowCount do 
    for x=1, rowSize do
      if not turtle.forward() then
        refuel()
        turtle.forward()
      end
      checkCrops()
    end
    nextRow()
  end
  replace()
end

function refuel()
  say("Refueling...")
  currentSlot = turtle.getSelectedSlot()
  turtle.select(16)
  while not turtle.refuel()  do 
    say("FARMING TURTLE NEEDS FUEL.")
    sleep(20)
  end
  say("Fuel Level at " .. turtle.getFuelLevel())
end

function plant()
  say("Planting Seeds...")
  selectingSeeds = false
  while not selectingSeeds do 
    slotInfo = turtle.getItemDetail()
    currentItem = ""
    if slotInfo ~= nil then
      currentItem = slotInfo.name
    end
    if currentItem == seeds then
      selectingSeeds = true
    else
      num = turtle.getSelectedSlot() + 1
      if num > 15 then
        num = 1
      end
      turtle.select(num)
      say("Searching for seeds in slot" .. num)
    end
  end
  if not turtle.placeDown() then  
    say("Failed. The space is occupied.")
  end
end

function checkCrops()
  say("Checking Crops...")
  if turtle.detectDown() then
    success, info = turtle.inspectDown()
    name = info.name
    if name == crop then
      say("Crop Detected...")
      growth = info.metadata
      if growth == 7 then
        say("Crop fully grown!")
        harvest()
      else
        say("Crop still growing...")
      end 
    end     
  else
    say("Space empty. Planting...")
    harvest()
  end
end

function harvest()
  say("Harvesting...")
  turtle.digDown()
  plant()
end 
function nextRow()
  say("Moving to next row...")
  shell.run(string.format("go back %d", rowSize))
  turtle.turnRight()
  turtle.forward()
  turtle.forward()
  turtle.turnLeft()
end

function replace()
  say("Moving to starting position...")
  turtle.turnLeft()
  shell.run(string.format("go forward %d", length - 1))
  turtle.down()
  turtle.turnRight()
  say("Finished!")
  shell.run("clear")
end

function say(message)
  print(message)
end

start()
say("END")
