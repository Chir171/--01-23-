using HorizonSideRobots
r = Robot("C:/Users/Александр/Desktop/untitled.sit";animate = true)
include("custom_ functions.jl")
include("recursion_functions.jl")
function recursion_chess(r::Robot,Side::HorizonSide,par::Int64)
    if mod(par,2) == 1
        putmarker!(r)
    end
    move!(r,Side)
    recusrsion_chess(r,Side,par+1)
end
function parametric_counter(r::Robot,limit::Int64)
    
end