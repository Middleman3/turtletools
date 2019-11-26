rednet.open("right")
print("Waiting for command...")
id, message = rednet.receive()
if message == "farm.lua" then
  shell.run("farm.lua")
end
os.reboot()
