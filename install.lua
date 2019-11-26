args = {...}
default_branch = "testing"
shell.setDir("/")
if fs.exists("turtletools") then fs.delete("turtletools") end
shell.run("github clone Middleman3/turtletools -b" .. (args[1] or default_branch))