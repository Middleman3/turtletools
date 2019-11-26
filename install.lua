args = {...}
default_branch = "testing"
settings.set("_tmp_dir", shell.dir())
settings.save()
shell.setDir("/")
if fs.exists("turtletools") then fs.delete("turtletools") end
shell.run("github clone Middleman3/turtletools -b " .. (args[1] or default_branch))
fs.delete("install")
fs.copy("turtletools/install.lua", "install")
current_dir = settings.get("_tmp_dir")
--settings.unset("_tmp_dir")
--settings.save()
print(current_dir)
shell.setDir(current_dir)