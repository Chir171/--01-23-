using HorizonSideRobots
r = Robot("C:/Users/Александр/Desktop/untitled.sit";animate = true)
include("custom_ functions.jl")
function spiral__(r::Robot,stop_condition::Function)
    counter_steps = 1
    Side = Sud
    while 1 == 1
        for i in 1:counter_steps
            try_move!(r,Side)
            if stop_condition()
                return
            end
        end
        Side = nextside(Side)
        for i in 1:counter_steps
            try_move!(r,Side)
            if stop_condition()
                return
            end
        end
        counter_steps += 1
        Side = nextside(Side)
    end
end
 
spiral__(r,()->ismarker(r))