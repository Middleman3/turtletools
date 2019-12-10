status = {idle="Waiting for Command"}
processes = {}

while true do
    id, message = rednet.receive()
    -- TODO verify sender
      -- add to processes

    words = {}
    for word in string.gmatch(message, "%a+") do
        table.insert(words, word)
    end
    multishell.launch(_G, unpack(words))
end


-- parallel.waitforAny(listenforterminate, actual program)
