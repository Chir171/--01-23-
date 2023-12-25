using HorizonSideRobots
r = Robot("C:/Users/Александр/Desktop/untitled.sit";animate = true)
inverse(Side::HorizonSide) = HorizonSide(mod(Int(Side)+2,4))
nextside(Side::HorizonSide) = HorizonSide(mod(Int(Side)+1,4))
prevside(Side::HorizonSide ) = HorizonSide(mod(Int(Side)-1,4))
function snake(Side_hz,Side_ver,counter)
    moves = []
    while !isborder(r,Side_ver)
        Side_hz = inverse(Side_hz)
        if counter == 1
            putmarker!(r)
        end
        while !isborder(r,Side_hz)
            move!(r,Side_hz)
            push!(moves,Side_hz)
            if counter == 1
                counter = 0 
            else
                counter = 1
            end
            if counter == 1
                putmarker!(r)
            end
        end
        if !isborder(r,Side_ver)
            move!(r,Side_ver)
            push!(moves,Side_ver)
            if counter == 1
                counter = 0 
            else
                counter = 1
            end
            if counter == 1
                putmarker!(r)
            end
        end
    end
    while !isborder(r,inverse(Side_hz))
        move!(r,inverse(Side_hz))
        push!(moves,inverse(Side_hz))
        if counter == 1
            counter = 0 
        else
            counter = 1
        end
        if counter == 1
            putmarker!(r)
        end
    end
    return [counter,reverse(moves)]
end
function go_inverse(move)
    for i in move
        move!(r,inverse(i))
    end
end
function n9()
    t = snake(Ost,Nord,1)
    n = snake(West,Sud,t[1])
    go_inverse(n[2])
    go_inverse(t[2])
end
n9()

    