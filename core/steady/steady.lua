
function refuel()
    go(prepared_to(turtle.dig, placing("enderstorage:ender_storage")))
    go(traversing_the(bucket_count, by(placing("minecraft:bucket"), turtle.refuel)))
    turtle.dig()
end