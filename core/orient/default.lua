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



