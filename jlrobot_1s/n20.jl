using HorizonSideRobots
r = Robot("C:/Users/Александр/Desktop/untitled.sit";animate = true)
include("custom_ functions.jl")
include("recursion_functions.jl")
function recursion_along_marker!(r::Robot,Side::HorizonSide,steps::Int64)
    if !isborder(r,Side)
        try_move!(r,Side)
        steps += 1
        steps += recursion_along!(r,Side,steps)
        return steps
    else 
        putmarker!(r)
        for i in 1:steps
            try_move!(r,inverse(Side))
        end
        return 0
    end
end
recursion_along_marker!(r,Ost,0)
