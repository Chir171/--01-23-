using HorizonSideRobots
r = Robot("C:/Users/Александр/Desktop/untitled.sit";animate = true)
include("custom_ functions.jl")
function pendulum__(r::Robot,Start_Side::HorizonSide,stop_condition::Function)
    step = 1
    while !stop_condition()
        for i in 1:step
            if try_move!(r,Start_Side)
                continue
            else
                break
            end
        end
        step += 1
        Start_Side = inverse(Start_Side)
    end
end
pendulum__(r,West,()->!isborder(r,Nord))