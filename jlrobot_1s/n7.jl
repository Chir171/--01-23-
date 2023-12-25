using HorizonSideRobots
r = Robot("C:/Users/Александр/Desktop/untitled.sit";animate = true)
inverse(Side::HorizonSide) = HorizonSide(mod(Int(Side)+2,4))
nextside(Side::HorizonSide) = HorizonSide(mod(Int(Side)+1,4))
prevside(Side::HorizonSide ) = HorizonSide(mod(Int(Side)-1,4))
function pendulum()
    step = 1
    while isborder(r,Nord)
        for i in 1:step
            move!(r,Ost)
            if !isborder(r,Nord)
                return
            end
        end
        step += 1
        for i in 1:step
            move!(r,West)
            if !isborder(r,Nord)
                return
            end
        end
        step += 1
    end
end
pendulum()