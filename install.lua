args = {...}
default_branch = "testing"
current_dir = shell.dir()
shell.setDir("/")
if fs.exists("turtletools") then fs.delete("turtletools") end
shell.run("github clone Middleman3/turtletools -b" .. (args[1] or default_branch))
shell.setDir(current_dir)