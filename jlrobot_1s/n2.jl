using HorizonSideRobots
r = Robot("sp/n1-4.sit";animate = true)
inverse(Side::HorizonSide) = HorizonSide(mod(Int(Side)+2,4))

function forward_back(steps::Int,Side::HorizonSide)
    steps_ = 0
    if steps == 0
        while !isborder(r,Side)
            move!(r,Side)
            steps_ += 1
        end
        return steps_
    else
        for i in 1:steps
            move!(r,Side)
        end
        return 0
    end
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

function n2()
    for i in [Nord,West,Ost,Sud]
        p = forward_back(0,i)
        str_side(HorizonSide(mod(Int(i)+1,4)))
        forward_back(p,inverse(i))
    end
end

n2()
