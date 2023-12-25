using HorizonSideRobots
r = Robot("C:/Users/Александр/Desktop/untitled.sit";animate = true)
inverse(Side::HorizonSide) = HorizonSide(mod(Int(Side)+2,4))
nextside(Side::HorizonSide) = HorizonSide(mod(Int(Side)+1,4))
prevside(Side::HorizonSide ) = HorizonSide(mod(Int(Side)-1,4))
function sqare(Size::Int)
    if Size == 0
        if ismarker(r)
            return 1
        end
    else
        for i in [Nord,West,Sud,Ost]
            for j in 1:Size
                move!(r,i)
                if ismarker(r)
                    return 1
                end
            end
        end
    end
end
function step(Side_v,Side_h)
        move!(r,Side_v)
        move!(r,Side_h)
end
function snail()
    ss = 0
    while !ismarker(r)
        res = sqare(ss)
        if res == 1
            break
        end
        ss += 2
        step(Sud,Ost)
    end
end
snail()