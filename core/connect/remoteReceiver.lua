rednet.open("left")
print("Waiting for Command...")
while true do
  id, message = rednet.receive()
  if id == 166 then
    shell.run(message)
    rednet.send(166, "END")
  end
end
