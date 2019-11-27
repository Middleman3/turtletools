args = {...}
rel_prog = args[1]
table.remove(args)
compile_path = "/turtletools/compile"
settings_path = "turtletools/.tt_settings"
tester = "it still works!"

if  table.getn(args) == 0 then print("Usage: trun <program> <args>") end

-- Compile
os.loadAPI("/turtletools/import.lua")
import.load_dir("turtletools/core")
print(1)
learn.going_forward()
print(extra_stuff)
print(2)
print("\nSearching for " .. rel_prog)
abs_prog = "/"..shell.resolve(rel_prog)
print("Running "..abs_prog)
if not shell.run(abs_prog, unpack(args)) then error("Execution failed.") end
