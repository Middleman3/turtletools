-- creates a square in the x, z or x, y plane, given direction y or z


function gradually(moving, distance, acting)
    return by(traversing_the(distance, by(moving, acting)), turning_right)
end

function retractively(moving, distance, acting)
    return by(gradually(moving, distance, acting), backward(traversing_the(distance, moving)))
end

function in_a_retractive_square (outer_moving, inner_moving, outer_length, inner_length, acting)
    return gradually(outer_moving, outer_length, retractively(inner_moving, inner_length, acting))
end

function in_a_zigzag_square(moving, zig, turning, zag, acting)
    local turn_around = by(turning, going_forward, turning)
    local turning_other_way = by(turning, turning, turning, going_forward, turning, turning, turning)
    local i = 0
    local im_coming_back = function()
        local odd = i % 2 == 1
        i = i + 1
        return odd
    end
    return traversing_the(zag, gradually(moving, zig, acting),
            provided(im_coming_back, turning_other_way, turn_around))
end

function edge_returning(width, length, height)
    return by(traversing_the(height, going_up),
                leftward(traversing_the(width, going_forward),
                    backward(traversing_the(length, going_forward))))
end

function in_a_block(width, length, height)
    return traversing_the(height, by(going_down, in_a_square(going_forward, length, width)))
end

function fence(fence_block, width, length, height)
    -- Walk from the center of a bottom side to the bottom left corner of fence
    go(leftward(traversing_the(width/2, going_forward)))

    local layMaterialAcrossThe = function (distance)
        return gradually(placingDown(fence_block), going_forward, distance)
    end

    placingSquareFence = by(
            layMaterialAcrossThe(length),
            layMaterialAcrossThe(width),
            layMaterialAcrossThe(length),
            layMaterialAcrossThe(width))

    go(gradually(placingSquareFence, going_up, height))

    -- come back to starting position
    go(by(rightward(traversing_the(width/2, going_forward)),
            going_back,
            traversing_the(height, going_down)))
end

function trenches(length, count)
    local digging_a_trench = by(gradually(turtle.digDown, going_forward, length), traversing_the(length, going_back))
    local going_to_next_position = leftward(by(going_forward, going_forward))
    go(traversing_the(count, digging_a_trench, going_to_next_position))
end