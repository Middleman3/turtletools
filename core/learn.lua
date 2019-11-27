
-- Steady

    -- Logical
function prepared_to(troubleshoot_cb, primary_cb)
    return function()
        print("trying something")
        local successful, error_code = primary_cb()
        if not successful then -- Attempt to move, return if successful
            print("it didn't work, so trying to fix it")
            if not troubleshoot_cb(error_code) then
                log.complain(error_code)
                print("couldn't fix it")
            else -- troubleshoot_cb worked
                print("I think I fixed it...")
                successful, error_code = primary_cb()
                if not successful then -- Attempt to move, return if successful
                    print("still didn't work... ")
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
            -- print("then I shall")
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
        print("time to traverse this thing")
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

function go(callback, ...)
    return callback(unpack(arg))
end

-- Movement

function get_def_mv_trbst(dig_func)
    return function(error_code)
        if not error_code then print("There's no error code")
        else print("Hmmm... "..error_code) end
        if error_code == "Movement obstructed" then return dig_func()
        elseif error_code == "Out of fuel" then return itemutils.refuel()
        else return false end
    end
end
function _make_default(move, dig, o_move)
    --print("making a default function")
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
        print("turning left")
        turning_left()
        callback()
        turning_right()
    end
end
function rightward(callback)
    return function ()
        print("turning right")
        turning_right()
        callback()
        turning_left()
    end
end
function backward(callback)
    return function ()
        print("turning around")
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

function placingDown(id)
    if not id then return turtle.placeDown end
    if tonumber(id) then -- given inventory slot id
        return function()
            tmp = turtle.getSelectedSlot()
            print("Placing down whatever's in slot " .. id)
            turtle.select(orient.one_based_mod(tmp, 16))
            successful, error_code = turtle.placeDown()
            turtle.select(tmp)
            return successful, error_code
        end
    else -- given block id
        return function()
            result = findMy(id)
            if result ~= -1 then
                print("Placing ".. id .. " down")
                turtle.placeDown()
                return true
            else
                print("Out of " .. id)
                return false, "Item not found"
            end
        end
    end
end
function placingUp(id)
    if not id then return turtle.placeUp end
    if tonumber(id) then -- given inventory slot id
        return function()
            tmp = turtle.getSelectedSlot()
            print("Placing down whatever's in slot " .. id)
            turtle.select(orient.one_based_mod(tmp, 16))
            successful, error_code = turtle.placeUp()
            turtle.select(tmp)
            return successful, error_code
        end
    else -- given block id
        return function()
            result = findMy(id)
            if result ~= -1 then
                print("Placing ".. id .. " down")
                turtle.placeUp()
                return true
            else
                print("Out of " .. id)
                return false, "Item not found"
            end
        end
    end
end
function placing(id)
    if not id then return turtle.place end
    if tonumber(id) then -- given inventory slot id
        return function()
            tmp = turtle.getSelectedSlot()
            print("Placing down whatever's in slot " .. id)
            turtle.select(orient.one_based_mod(tmp, 16))
            successful, error_code = turtle.place()
            turtle.select(tmp)
            return successful, error_code
        end
    else -- given block id
        return function()
            result = findMy(id)
            if result ~= -1 then
                print("Placing ".. id .. " down")
                turtle.place()
                return true
            else
                print("Out of " .. id)
                return false, "Item not found"
            end
        end
    end
end

