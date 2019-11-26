function getTime()
  return "Day " .. os.day() .. " at " .. os.time()
end

function createLog(label)
  logCount = settings.get("logCount") + 1
  settings.set("logCount", logCount)
  settings.save(".settings")
  if label == nil then label = "" end
  return fs.open(label.."/logs/"..label.."Log"..logCount, "a")
end

function record(file, message)
  file.writeLine(message)
end
  
