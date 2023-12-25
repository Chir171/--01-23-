using HorizonSideRobots
include("custom_ functions.jl")

function recursion_along!(r::Robot,Side::HorizonSide,stop_condition::Function)
    steps = 0
    if !stop_condition()
        if try_move!(r,Side)
        else
            return steps
        end
        steps += 1
        steps += recursion_along!(r,Side,()->stop_condition())
    end
    return steps
end

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

function recursion_along_border!(r::Robot,Side::HorizonSide)
    if try_move!(r,Side)
        recursion_along_border!(r,Side)
    end
end
