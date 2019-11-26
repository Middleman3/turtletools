sideCount = 10
for i=1, sideCount do 
  for j=1, i do 
    turtle.dig()
    if not turtle.forward() then
      slotNum = turtle.getSelectedSlot()
      turtle.select(16)
      turtle.refuel(1)
      turtle.select(slotNum)
      turtle.forward()
    end
    turtle.digDown()
  end  
  turtle.turnRight()
end
