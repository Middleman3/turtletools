args = {...}
default_branch = "testing"
current_dir = shell.dir()
print(current_dir)
shell.setDir("/")
if fs.exists("turtletools") then fs.delete("turtletools") end
shell.run("github clone Middleman3/turtletools -b " .. (args[1] or default_branch))
fs.delete("install")
query = fs.find("*install.lua")
print(textutils.serialize(query))
fs.copy(query[1], "/install")
print(current_dir)
shell.setDir(current_dir)