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
