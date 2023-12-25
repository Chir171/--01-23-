using HorizonSideRobots
r = Robot("C:/Users/Александр/Desktop/untitled.sit";animate = true)
include("custom_ functions.jl")
include("recursion_functions.jl")
function recursion_along_blesim!(r::Robot,Side::HorizonSide,steps::Int64)
    if !isborder(r,Side)
        try_move!(r,Side)
        steps += 1
        steps += recursion_along_blesim!(r,Side,steps)
        return steps
    else
        thru(r,Side)
        for i in 1:steps
            try_move!(r,Side)
        end
        return 0
    end
end
recursion_along_blesim!(r,West,0)

