SETTINGS_PATH = ".settings"

function colored(color, saying)
    return function()
        term.setTextColor(colors[color])
        saying()
        term.setTextColor(colors.white)
    end
end

--[[function timestamped(saying)

end]]

saying = function(...)
    return function ()
        print(unpack(arg))
    end
end

complain = function (message, detail)
    term.setTextColor(colors.orange)
    print(message)
    if detail then info(detail) end
    term.setTextColor(colors.white)
end

query = function(question)
    colored("purple", saying(question))()
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
    rednet.open(get_modem_side())
end

init()


--[[
function complain(message)
    error(message)
end



end]]
