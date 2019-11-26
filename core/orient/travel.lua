args = {...}
success = os.loadAPI("orient")

function primitive_move(path)
    print("O:move: ",path:tostring())
    a, b, c = string.match(path:tostring(), '(.?%d+),(.?%d+),(.?%d+)')
    x = tonumber(a)
    y = tonumber(b)
    z = tonumber(c)
    continue = function () return not(x==0 and y==0 and z==0) end
    while continue do
        if x>0 then
            right()
            forward()
            left()
            x = x - 1
        elseif x<0 then
            left()
            foward()
            right()
            x = x + 1
        end
        if y>0 then
            up()
            y = y - 1
        elseif y<0 then
            down()
            y = y + 1
        end
        if z>0 then
            forward()
            z = z - 1
        elseif z<0 then
            back()
            z = z + 1
        end
        print(x,y,z)
    end
end

if args[3] == nil then
  error("travel takes 3 arguments: x y z")
end
x = tonumber(args[1])
y = tonumber(args[2])
z = tonumber(args[3]) 
if x ~= nil and y ~= nil and z ~= nil then
   route = vector.new(x,y,z)
   orient.move(route)
end  
  
  
