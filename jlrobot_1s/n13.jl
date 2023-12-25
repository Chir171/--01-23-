using HorizonSideRobots
r = Robot("C:/Users/Александр/Desktop/untitled.sit";animate = true)
include("custom_ functions.jl")
function chess_snake!(r::Robot,Side_hz::HorizonSide,Side_ver::HorizonSide,stop_condition::Function,steps::Int)
    while 1==1
        move_direction = possible_direction!(r)
        if mod(steps,2) == 0
            putmarker!(r)
        end
        if Side_hz in move_direction[2]
            try_move!(r,Side_hz)
            steps += 1
        else
            if stop_condition()
                break
            end
            try_move!(r,Side_ver)
            steps += 1
            Side_hz = inverse(Side_hz)
        end
    end
end
function n13()
    steps = possible_corner!(r,West,Sud)
    chess_snake!(r,Ost,Nord,()->isborder(r,Nord),mod(length(steps),2))
    possible_corner!(r,West,Sud)
    array_of_steps!(r,steps)
end
n13()