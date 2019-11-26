
-- Steady

    -- Logical
function determined(troubleshoot_cb, movement_cb)
    return function()
        successful, error_code = movement_cb()
        if not successful then -- Attempt to move, return if successful
            if not troubleshoot_cb(error_code) then
                log.complain(error_code)
            else -- troubleshoot_cb worked
                if not movement_cb() then
                    log.complain("Unknown reason for inability to move!")
                end
            end
        end
    end
end
-- by as in 'via' or 'by means of' this given sequence of routines
print("1")
function by(...)
    return function()
        for i, funct in ipairs(arg) do funct() end
    end
end
print("2")
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

-- Movement

function get_def_mv_trbst(dig_func)
    return function(error_code)
        if error_code == "Movement obstructed" then return dig_func()
        elseif error_code == "Out of fuel" then return refuel()
        else return false end
    end
end
function _make_default(move, dig, o_move)
    return determined(by(move, o_move), get_def_mv_trbst(dig))
end

-- Primaries
going_up = _make_default(turtle.up, turtle.digUp, o_up)
going_forward = _make_default(turtle.forward, turtle.dig, o_forward)
going_down =_make_default(turtle.down, turtle.digDown, o_down)

-- Facing
function turning_left()
    o_left()
    turtle.turnLeft()
end
function turning_right()
    o_left()
    turtle.turnRight()
end

-- Directional
function leftward(callback)
    return function ()
        turning_left()
        callback()
        turning_right()
    end
end
function rightward(callback)
    return function ()
        turning_right()
        callback()
        turning_left()
    end
end
function backward(callback)
    return function ()
        turning_left()
        turning_left()
        callback()
        turning_right()
        turning_right()
    end
end

-- Directional (Depreciated?)
going_back = backward(going_forward())
going_left = leftward(going_forward())
going_right = rightward(going_forward())


-- Interact

function placingDown(material_id)
    return function()
        result = findMy(material_id)
        if not result == -1 then
            turtle.placeDown()
        end
    end
end
function placingUp(material_id)
    return function()
        result = findMy(material_id)
        if not result == -1 then
            turtle.placeUp()
        end
    end
end
function placing(material_id)
    return function()
        result = findMy(material_id)
        if not result == -1 then
            turtle.place()
        end
    end
end