using HorizonSideRobots
r = Robot("C:/Users/Александр/Desktop/nomer21.sit";animate = true)
include("custom_ functions.jl")
include("recursion_functions.jl")
function thru(r::Robot,Side::HorizonSide)
    if try_move!(r,Side)
    else
        md = nextside(Side)
        steps = recursion_along!(r,md,()->!isborder(r,Side))
        if isborder(r,md)
            go!(r,inverse(md),steps)
            md = inverse(md)
            steps = recursion_along!(r,md,()->!isborder(r,Side))
        end
        try_move!(r,Side)
        go!(r,inverse(md),steps)
    end
end
thru(r,Ost)
