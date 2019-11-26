args = {...}
if table.getn(args) == 0 then print("Usage: trun <program>") end
if not shell.run("/turtletools/compile") then error("Compilation failed, reinstall.") end
print("searching for " .. args[1])
program = shell.resolve(args[1])
print(program)
if not shell.run(program) then error("Execution failed.") end
