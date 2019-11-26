args = {...}
compile_path = "/turtletools/compile"
settings_path = "turtletools/.tt_settings"

if table.getn(args) == 0 then print("Usage: trun <program>") end
if not shell.run(compile_path) then error("Compilation failed, reinstall.") end
if not settings.load(settings_path) then error("Settings could not be loaded.") end
print("\nSearching for " .. args[1])
program = "/"..shell.resolve(args[1])
print(program)
if not os.run(program) then error("Execution failed.") end
