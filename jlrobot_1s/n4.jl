using HorizonSideRobots
r = Robot("sp/n1-4.sit";animate = true)
inverse(Side::HorizonSide) = HorizonSide(mod(Int(Side)+2,4))
function step(Side_v,Side_h)
    moving = 0
    if !isborder(r,Side_v) && !isborder(r,Side_h)
        move!(r,Side_v)
        move!(r,Side_h)
        putmarker!(r)
        moving += 1
    end
    return moving
end
function n4()
    putmarker!(r)
    for i in [Nord,Sud]
        for j in [Ost,West]
            counter_steps = 0
            while step(i,j) == 1
                counter_steps += 1
            end
            for g in 1:counter_steps
                step(inverse(i),inverse(j))
            end
        end
    end
end
n4()
