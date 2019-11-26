-- initiate
args = {...}
default_branch = "testing"
key = "tmp"
settings.set(key, shell.dir())
settings.save(".settings")
shell.setDir("/")

-- out with the old
fs.delete("turtletools")
fs.delete("install")
fs.delete("tt")

-- in with the new
shell.run("github clone Middleman3/turtletools -b " .. (args[1] or default_branch))
fs.copy("turtletools/install.lua", "install")
fs.copy("turtletools/tt_run.lua", "tt")

-- wrap it up
current_dir = settings.get(key)
settings.unset(key)
settings.save(".settings")
shell.setDir(current_dir)