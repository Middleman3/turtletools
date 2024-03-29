function load(path)
    print(path)
    successful = os.loadAPI(path)
end
-- recursive depth first search
function load_dir(dir_path)
    paths = fs.list(dir_path)
    for i, path in ipairs(paths) do
        path = path or ""
        full_path = dir_path.."/"..path
        if fs.isDir(full_path) then load_dir(full_path)
        else load(full_path) end
    end
end
function import(package)
    full_path = shell.resolve(package)
    load(full_path)
end

-- spills elements of this package into _G, so package.element -> element
function spill(package)
    for symbol, value in pairs(package) do
        _G[symbol] = value
    end
    _G[package] = nil
end
