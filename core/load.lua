

successful = pcall(function () os.loadAPI("turtletools/connect/complain") end)
if not successful then complain("cannot find " .. complain) end

str_dir = shell.resolve("turtletools")

function load(path)
    successful = pcall(function () os.loadAPI(path) end)
    if not successful then complain("cannot find " .. path) end
end

-- recursive depth first search
function load_dir(dir_path)
    paths = fs.list(dir_path)
    for i, path in ipairs(paths) do
        if fs.isDir(path) then load_dir(path)
        else load(path) end
    end
end

load_dir(str_dir)
