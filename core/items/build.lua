
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
function flatten(width, length, height)
    slicing = traversing_the(length, by(going_forward, rightward(traversing_the(width, going_forward()))))
    go(traversing_the(height, by(going_down, slicing)))
end
function fence(fence_block, width, length, height)
    -- Walk from the center of a bottom side to the bottom left corner of fence
    go(leftward(traversing_the(width/2, going_forward)))

    layMaterialAcrossThe = function (distance)
        return by(traversing_the(distance, by(going_forward, placingDown(fence_block))), turning_right)
    end

    placingSquareFence = function ()
        return function()
            by(
            layMaterialAcrossThe(length),
            layMaterialAcrossThe(width),
            layMaterialAcrossThe(length),
            layMaterialAcrossThe(width))

        end
    end

    go(traversing_the(height, by(going_up, placingSquareFence)))

    -- come back to starting position
    go(rightward(traversing_the(width/2, going_forward)))
    going_back()
    go(traversing_the(height, going_down))
end
function trenches(length, count)
    digging_a_trench = function ()
        return by(traversing_the(length, by(going_forward, turtle.digDown)), traversing_the(length, going_back))
    end

    going_to_next_position = function ()
        return leftward(by(going_forward, going_forward))
    end

    go(traversing_the(count, digging_a_trench, going_to_next_position))
end