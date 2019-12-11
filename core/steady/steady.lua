
function refuel()
    go(prepared_to(turtle.dig, placing("enderstorage:ender_storage")))
    go(traversing_the(bucket_count, by(placing("minecraft:bucket"), turtle.refuel)))
    turtle.dig()
end

function deposit_items(ignored_ids)
    success, error_code = go(prepared_to(turtle.dig, placing("enderstorage:ender_storage")))
    if not success then return false, error_code end
    itemutils.dump(ignored_ids)
    turtle.dig()
end