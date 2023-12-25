using HorizonSideRobots
r = Robot("sp/n1-4.sit";animate = true)
function inverse(Side::HorizonSide)
    return HorizonSide(mod(Int(Side)+2,4))
end
function str_side(Side::HorizonSide)
    counter = 0
    while !isborder(r,Side)
        move!(r,Side)
        putmarker!(r) 
        counter += 1
    end
    while !isborder(r,inverse(Side))
        move!(r,inverse(Side))
        putmarker!(r)
        counter -= 1
    end
    for i in 1:abs(counter)
        move!(r,Side)
    end
end
function _cross()
        str_side(Nord)
        str_side(West)
end
_cross()
