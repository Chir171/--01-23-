using HorizonSideRobots
r = Robot("sp/n5.sit";animate = true)
inverse(Side::HorizonSide) = HorizonSide(mod(Int(Side)+2,4))
nextside(Side::HorizonSide) = HorizonSide(mod(Int(Side)+1,4))
prevside(Side::HorizonSide ) = HorizonSide(mod(Int(Side)-1,4))
function bottom_right()
    moves = []
    while !isborder(r,Sud) || !isborder(r,Ost)
        if isborder(r,Sud)
            move!(r,Ost)
            push!(moves,Ost)
        else
            move!(r,Sud)
            push!(moves,Sud)
        end
    end
    return reverse(moves)
end
function marking_outside_border(Side)
    for i in 1:4
        while !isborder(r,Side)
            move!(r,Side)
            putmarker!(r)
        end
        Side = nextside(Side)
    end
end
function line(Side_hz::HorizonSide,Side_ver::HorizonSide)
    counter = 0
    while !isborder(r,Side_hz)
        move!(r,Side_hz)
        counter += 1
    end
    if !isborder(r,Side_ver)
        move!(r,Side_ver)
    end
    return counter
end
function snake(Side_ver,Side_hz)
    i = inverse(Side_hz)
    p = line(Side_hz,Side_ver)
    p_copy = p
    while (!isborder(r,Side_ver) || !isborder(r,Side_hz)) && p_copy == p
        p_copy = line(i,Side_ver)
        i = inverse(i)
    end
    if p_copy != p
        return inverse(i)
    end
end
function marking_inside_border(Side)
    m1 = [Side,Sud,inverse(Side),Nord,Side]
    m2 = [Nord,Side,Sud,inverse(Side),Nord]
    for i in 1:4
        while isborder(r,m1[i])
            putmarker!(r)
            move!(r,m2[i])
        end
        putmarker!(r)
        move!(r,m2[i+1])
        putmarker!(r)
    end
end
function go_inverse(move)
    for i in move
        move!(r,inverse(i))
    end
end
function n5()
    t = bottom_right()
    marking_outside_border(Nord)
    l = snake(Nord,West)
    marking_inside_border(l)
    bottom_right()
    go_inverse(t)
end
n5()