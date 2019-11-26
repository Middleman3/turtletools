args = {...}
if args[1] == nil then 
  error("Takes 1 argument: on or off")
end
rednet.open("back")
rednet.broadcast(args[1])
