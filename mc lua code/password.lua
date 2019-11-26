locked = false
print("What's the password?")
input = read()
password = "something"

if input == password then
  print("Access Granted!")
  shell.run("redstone set right true")
elseif input == "secret" then
  shell.run("redstone pulse right 1 3")
else
  print("Get lost, intruder!")
end  
  
sleep(5)
os.reboot()  
