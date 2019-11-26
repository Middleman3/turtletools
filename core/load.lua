successful = os.loadAPI("/turtletools/core/connect/log.lua")
if not successful then log.complain = print end

str_dir = "turtletools"

function load(path)
    successful = os.loadAPI(shell.resolve(path))
    --if not successful then log.complain("cannot find " .. path) end
end

-- recursive depth first search
function load_dir(dir_path)
    paths = fs.list(dir_path)
    for i, path in ipairs(paths) do
        full_path = dir_path.."/"..path
        if fs.isDir(full_path) then load_dir(full_path)
        else load(full_path) end
    end
end

load_dir(str_dir)
