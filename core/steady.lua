if not successful then complain("cannot load connect.lua") end

-- Logical
function determined(troubleshoot_cb, movement_cb)
    return function()
        successful, error_code = movement_cb()
        if not successful then -- Attempt to move, return if successful
            if not troubleshoot_cb(error_code) then
                complain(error_code)
            else -- troubleshoot_cb worked
                if not movement_cb() then
                    complain("Unknown reason for inability to move!")
                end
            end
        end
    end
end
-- by as in 'via' or 'by means of' this given sequence of routines
function by(...)
    return function()
        for i, funct in args do funct() end
    end
end

function conditional(condition_cb, secondary_cb, primary_cb)
    return function()
        if condition_cb() then return primary_cb()
        else return secondary_cb end
    end
end
-- Looping
function traversing_the(count, primary_cb, transition_cb)
    return function()
        if count == 0 then return end
        if not primary_cb() then return false end
        for i=0, count - 1 do
            if not transition_cb() then return false end
            if not primary_cb() then return false end
        end
        return true
    end
end
function continual(condition_cb, primary_cb)
    return function ()
        while condition_cb() do
            if not primary_cb() then return false end
        end
        return true
    end
end

function go(callback, ...)
    return callback(unpack(args))
end

