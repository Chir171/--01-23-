using HorizonSideRobots
r = Robot("C:/Users/Александр/Desktop/untitled.sit";animate = true)
include("custom_ functions.jl")
include("recursion_functions.jl")
function aside(r::Robot,Side::HorizonSide)
    hz_step = 0
    ver_step = 0
    while isborder(r,Side)
        if isborder(r,Side) && isborder(r,Nord)
            for i in 1:ver_step
                move!(r,Sud)
            end
            return 0
        end
    end
        move!(r,Nord)
        ver_step += 1
    move!(r,Side)
    hz_step += 1
    while isborder(r,Sud)
        move!(r,Side)
        hz_step += 1
    end
    for i in 1:ver_step
        move!(r,Sud)
    end
    return hz_step
end

aside(r,West)
