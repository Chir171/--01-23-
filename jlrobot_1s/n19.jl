using HorizonSideRobots
r = Robot("C:/Users/Александр/Desktop/untitled.sit";animate = true)
include("custom_ functions.jl")
function recursion_along_border!(r::Robot,Side::HorizonSide)
    if try_move!(r,Side)
        recursion_along!(r,Side)
    end
end

recursion_along!(r,West)