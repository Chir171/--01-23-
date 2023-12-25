using HorizonSideRobots
r = Robot("C:/Users/Александр/Desktop/untitled.sit";animate = true)
include("custom_ functions.jl")
include("recursion_functions.jl")
function ble(r::Robot,Side::HorizonSide,steps::Int64,otvet::Bool)
    if !isborder(r,Side)
        try_move!(r,Side)
        steps += 1
        steps += ble(r,Side,steps,otvet)
        return steps
    else 
        for i in 1:steps*2
            if try_move!(r,inverse(Side))
            else
                otvet = false
                for j in  1:(i-steps-1)
                    move!(r,Side)
                end
                return 0
            end
        end
        return 0
    end
    return otvet
end
ble(r,Ost,0,true)