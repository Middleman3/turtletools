args = {...}
default_branch = "testing"
key = "tmp"
settings.set(key, shell.dir())
settings.save(".settings")
shell.run("set")
shell.setDir("/")
if fs.exists("turtletools") then fs.delete("turtletools") end
shell.run("github clone Middleman3/turtletools -b " .. (args[1] or default_branch))
fs.delete("install")
fs.copy("turtletools/install.lua", "install")
current_dir = settings.get(key)
--settings.unset(key)
--settings.save(".settings")
print(current_dir)
shell.setDir(current_dir)