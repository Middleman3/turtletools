SETTINGS_PATH = "turtletools/.tt_settings"
settings.load(SETTINGS_PATH)

-- sync with persistence
function setD (direction)
  settings.set("D", direction)
  settings.save(SETTINGS_PATH)
end
function setH(vectorToHome)
  settings.set("H", vectorToHome:tostring())
  settings.save(SETTINGS_PATH)
end
function getH()
  H = settings.get("H")
  x, y, z = string.match(H, "(.?%d+),(.?%d+),(.?%d+)")
  return vector.new(x, y, z)  
end

-- map directions
compass = {"west", "north", "east", "south"}
compass_vectors = {vector.new(-1, 0, 0), -- west
                   vector.new(0, 0, 1), -- north
                   vector.new(1, 0, 0), -- east
                   vector.new(0, 0, -1)} -- south

-- Utility Functions
function one_based_modulus(dividend, divisor)
  -- Lua collections are 1 based, and modulus is needed to loop through circular array 'compass'
  dividend = dividend - 1 -- make zero based
  result = dividend % divisor
  return result + 1 -- back to 1 based
end
function indexOf(array, element)
  for i, v in ipairs(array) do
    if v == element then return i end
  end
  log.complain("Direction attribute improperly set to " .. dir_str)
end

-- Movement
function turn_helper(num)
  dir_str = settings.get("D")
  if not dir_str then return false, "corrupted settings" end
  dir = indexOf(compass, dir_str)
  new_dir = dir + num
  one_based_modulus(new_dir, 4) -- wrap around (4 directions)
  new_dir_str = compass[new_dir]
  setD(new_dir_str)
  return true
end

function right()
  return turn_helper(1)
end
function left()
  return turn_helper(-1)
end
function up()
  H = getH()
  if not H then return false, "corrupted settings" end
  setH(H:add(vector.new(0, 1, 0)))
  return true
end
function down()
  H = getH()
  if not H then return false, "corrupted settings" end
  setH(H:add(vector.new(0, -1, 0)))
  return true
end
function forward()
  D = getD()
  H = getH()
  if not D then return false, "corrupted settings" end
  if not H then return false, "corrupted settings" end
  dir_vector = compass_vectors[indexOf(compass, D)]
  setH(H:add(dir_vector))
  return true
end
function back()
  D = getD()
  H = getH()
  if not D then return false, "corrupted settings" end
  if not H then return false, "corrupted settings" end
  dir_vector = compass_vectors[indexOf(compass, D)]
  setH(H:sub(dir_vector))
  return true
end
function report()
  return "at " .. settings.get("H") .. " facing " .. settings.get("D")
end
--args = {...}
--setD(args[1])
--home = vector.new(args[2], args[3], args[4])
--setH(home)
--print("At "..args[2].." "..args[3].." "..args[4].." facing "..args[1])
