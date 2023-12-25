using HorizonSideRobots

inverse(Side::HorizonSide) = HorizonSide(mod(Int(Side)+2,4))

nextside(Side::HorizonSide) = HorizonSide(mod(Int(Side)+1,4))

prevside(Side::HorizonSide ) = HorizonSide(mod(Int(Side)-1,4))

function try_move!(r::Robot,Side::HorizonSide)
    if !isborder(r,Side)
        move!(r,Side)
        return true
    else
        return false
    end
end

function line!(r::Robot,Side::HorizonSide)
    moves = []
    while !isborder(r,Side)
        putmarker!(r)
        move!(r,Side)
        push!(moves,inverse(Side))
        putmarker!(r)
    end
    return reverse(moves)
end

function vertical_redirection!(r::Robot,Side_hz::HorizonSide,Side_ver::HorizonSide)
    if !isborder(r,Side_ver)
        move!(r,Side_ver)
        return inverse(Side_hz)
    else
        return false
    end
end

function snake!(r::Robot,Side_hz::HorizonSide,Side_ver::HorizonSide)
    line!(r,Side_hz)
    redirection_flag = vertical_redirection!(r,Side_hz,Side_ver)
    while redirection_flag != 0
        line!(r,redirection_flag)
        redirection_flag = vertical_redirection!(r,redirection_flag,Side_ver)
    end
end

function possible_corner!(r::Robot,Side_hz::HorizonSide,Side_ver::HorizonSide)
    moves = []
    while !isborder(r,Side_hz) || !isborder(r,Side_ver)
        if try_move!(r,Side_hz)
            push!(moves,inverse(Side_hz))
        end
        if try_move!(r,Side_ver)
            push!(moves,inverse(Side_ver))
        end
    end
    return reverse(moves)
end

function array_of_steps!(r::Robot,moves::Array)
    for i in moves
        try_move!(r,i)
    end
end

function possible_direction!(r::Robot)
    counter_sides = 0 
    sides = []
    for i in [Ost,West,Nord,Sud]
        if !isborder(r,i)
            counter_sides += 1
            push!(sides,i::HorizonSide)
        end
    end
    return [counter_sides,sides]
end

function snake__(r::Robot,Side::HorizonSide,stop_condition::Function)
    while stop_condition() == 0
        line!(r,Side)
        Side = vertical_redirection!(r,Side,Nord)
    end
    line!(r,Side)
end

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

function go!(r::Robot,Side::HorizonSide,steps)
    for i in 1:steps
        move!(r,Side)
    end
end