modemSide = "top"
lampSide = "front"

rednet.open(modemSide)
print("Waiting for Command...")
while true do 
  id, message = rednet.receive()
  if message == "on" then
    redstone.setOutput(lampSide, true)
  elseif message == "off" then
    redstone.setOutput(lampSide, false)
  end
end
