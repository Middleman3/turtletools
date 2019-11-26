os.loadAPI("log")
rednet.open("back")
rednet.broadcast("farm.lua")
term.redirect(peripheral.wrap("top"))
term.clear()
count = 0
file = log.createLog("farm.lua")
time = log.getTime()
log.record(file, time)

while true do 
  id, message = rednet.receive()
  if id == 175 then
    if message == "END" then break end
    count = count + 1
    message = count .. ": " .. message
    print(message) 
    log.record(file, message) 
  end
end
file.close()
print("New log file created.")


