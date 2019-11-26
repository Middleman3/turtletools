args = {...}
rel_prog = args[1]
table.remove(args)
compile_path = "/turtletools/compile"
settings_path = "turtletools/.tt_settings"

if #args == 0 then print("Usage: trun <program> <args>") end
if not shell.run(compile_path) then error("Compilation failed, reinstall.") end
if not settings.load(settings_path) then error("Settings could not be loaded.") end

env = settings.get("_G")

print("\nSearching for " .. rel_prog)
abs_prog = "/"..shell.resolve(rel_prog)
print("Running "..abs_prog)
if not os.run(env, abs_prog, unpack(args)) then error("Execution failed.") end
