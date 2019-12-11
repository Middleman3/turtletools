
-- Steady

    -- Logical
function prepared_to(troubleshoot_cb, primary_cb)
    return function()
        -- log.info("trying something")
        local successful, error_code = primary_cb()
        if not successful then -- Attempt to move, return if successful
            log.info("it didn't work, so trying to fix it")
            if not troubleshoot_cb(error_code) then
                log.complain(error_code)
                log.info("couldn't fix it")
            else -- troubleshoot_cb worked
                log.info("I think I fixed it...")
                successful, error_code = primary_cb()
                if not successful then -- Attempt to move, return if successful
                    log.complain("still didn't work... ")
                    return false, error_code
                else return true end
            end
        else return true end
    end
end
-- by as in 'via' or 'by means of' this given sequence of routines

function by(...)
    return function()
        for i, funct in ipairs(arg) do
            local successful, error_code = funct()
            if not successful then return false, error_code end
            -- log.info("then I shall")
        end
        return true
    end
end

function provided(condition_cb, primary_cb, secondary_cb)
    secondary_cb = secondary_cb or function() return true end
    return function()
        if condition_cb() then return primary_cb()
        else return secondary_cb() end
    end
end
    -- Looping
function traversing_the(count, primary_cb, transition_cb)
    return function()
        -- log.info("time to traverse this thing")
        if count == 0 then return end
        local successful, error_code = primary_cb()
        if not successful then return false, error_code end
        for i=0, count - 1 do
            if transition_cb then
                successful, error_code = transition_cb()
                if not successful then return false, error_code end
            end
            successful, error_code = primary_cb()
            if not successful then return false, error_code end
        end
        return true
    end
end
function as_long_as(condition_cb, primary_cb)
    return function ()
        while condition_cb() do
            local successful, error_code = primary_cb()
            if not successful then return false, error_code end
        end
        return true
    end
end

-- TODO Add Error Checking and Reporting here
function go(callback, ...)
    return callback(unpack(arg))
end

-- Movement
function get_def_mv_trbst(dig_func)
    return function(error_code)
        if not error_code then log.complain("There's no error code")
        else log.info("Hmmm... "..error_code) end
        if error_code == "Movement obstructed" then return dig_func()
        elseif error_code == "Out of fuel" then return itemutils.refuel()
        else return false end
    end
end
function _make_default(move, dig, o_move)
    --log.info("making a default function")
    return prepared_to(get_def_mv_trbst(dig), by(move, o_move))
end

-- Primaries
going_up = _make_default(turtle.up, turtle.digUp, orient.up)
going_forward = _make_default(turtle.forward, turtle.dig, orient.forward)
going_down =_make_default(turtle.down, turtle.digDown, orient.down)

-- Facing
function turning_left()
    orient.left()
    turtle.turnLeft()
end
function turning_right()
    orient.right()
    turtle.turnRight()
end

-- Directional
function leftward(callback)
    return function ()
        --log.info("turning left")
        turning_left()
        callback()
        turning_right()
    end
end
function rightward(callback)
    return function ()
        --log.info("turning right")
        turning_right()
        callback()
        turning_left()
    end
end
function backward(callback)
    return function ()
        --log.info("turning around")
        turning_left()
        turning_left()
        callback()
        turning_right()
        turning_right()
    end
end

-- Directional
going_back = backward(going_forward)
going_left = leftward(going_forward)
going_right = rightward(going_forward)

-- Interact

function placing_helper(id, cb)
    if not id then return cb end
    if tonumber(id) then -- given inventory slot id
        return function()
            tmp = turtle.getSelectedSlot()
            log.info("Placing down whatever's in slot " .. id)
            turtle.select(orient.one_based_mod(tmp, 16))
            successful, error_code = cb()
            turtle.select(tmp)
            return successful, error_code
        end
    else -- given block id
        return function()
            result = itemutils.findMy(id)
            if result ~= -1 then
                log.info("Placing ".. id .. " down")
                success, error_code = cb()
                turtle.select(result)
                return success, error_code
            else
                log.complain("Out of " .. id)
                turtle.select(result)
                return false, "Item not found"
            end
        end
    end
end
function placing(id) placing_helper(id, turtle.place) end
function placingUp(id) placing_helper(id, turtle.placeUp) end
function placingDown(id) placing_helper(id, turtle.placeDown) end

