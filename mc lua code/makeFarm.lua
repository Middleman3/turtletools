successful = os.loadAPI("../orient/orient")
if not successful then log.complain("cannot load orient.lua") end
successful = os.loadAPI("../steady")
if not successful then log.complain("cannot load steady.lua") end

function trenches(length, count)
  for i=1, count do
    for j=1, length do
      turtle.dig()
      if not turtle.forward() then
        refuel()
        turtle.forward()
      end
      turtle.digDown()
    end
    for i=1, length do
      if not turtle.back() then
        refuel()
        turtle.back()
      end
    end
    turtle.turnRight()
    turtle.forward()
    turtle.forward()
    turtle.turnLeft()
  end
  turtle.turnLeft()
  shell.run("go forward "..count*2 + 1)
  turtle.turnRight()  
end 
