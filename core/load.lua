

successful = os.loadAPI("turtletools/connect/complain")
--if not successful then complain("cannot find " .. complain) end

str_dir = shell.dir()

function load(path)
    successful = os.loadAPI(shell.resolve(path))
    --if not successful then complain("cannot find " .. path) end
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
