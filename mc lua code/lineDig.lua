length = 15
downTask = turtle.placeDown 
for i=1, length do 
  turtle.dig()
  if not turtle.forward() then
    slotNum = turtle.getSelectedSlot()
    turtle.select(16)
    turtle.refuel(1)
    turtle.select(slotNum)
  end
  downTask()
end
