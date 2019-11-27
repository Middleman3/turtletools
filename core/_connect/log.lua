SETTINGS_PATH = ".settings"
info = function(message, detail)
    term.setTextColor(colors.lightBlue)
    print(message)
    if detail then info(detail) end
    term.setTextColor(colors.white)
end

complain = function (message, detail)
    term.setTextColor(colors.orange)
    print(message)
    if detail then info(detail) end
    term.setTextColor(colors.white)
end

query = function(question)
    info(question)
    return read()
end

function query_modem_side()
    settings.set("modem_side", query("Which side is my modem on? (top, bottom, left, right, back)"))
    settings.save(SETTINGS_PATH)
end

function get_modem_side()
    m = settings.get("modem_side")
    if m then return m end
    complain("corrupted settings, no modem_side")
    return nil
end

function init()
    settings.load(SETTINGS_PATH)
    if not get_modem_side() then query_modem_side() end
end

init()


--[[
function complain(message)
    error(message)
end

info = function (message, details)

end]]
