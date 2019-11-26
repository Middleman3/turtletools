args = {...}
if table.getn(args) == 0 then print("Usage: trun <program>") end
if not shell.run("/turtletools/compile") then error("Compilation failed, reinstall.") end
if not shell.run(shell.resolve(args[1])) then error("Execution failed.") end
