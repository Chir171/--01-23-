using HorizonSideRobots
r = Robot("C:/Users/Александр/Desktop/untitled.sit";animate = true)
include("custom_ functions.jl")
function coords_moving(r::Robot,c::Array,Side::HorizonSide)
    if Side == Nord
        return [c[1],c[2]+1]
    end
    if Side == Sud
        return [c[1],c[2]-1]
    end
    if Side == Ost
        return [c[1]+1,c[2]]
    end
    if Side == West
        return [c[1]-1,c[2]]
    end
end
function bc(r::Robot)
    cnt = 0
    side = []
    for i in [Nord,Ost,Sud,West]
        if isborder(r,i)
            cnt += 1
            push!(side,i)
        end
    end
    return [cnt,side]
end
function where(r)
    coords = [0,0]
    direction = bc(r)[2][1]
    points = 0
    lefts = 0
    rights = 0
    while points < 4
        if coords == [0,0]
            points += 1
            if points > 4
                break
            end
        end
        if try_move!(r,nextside(direction))
            coords = coords_moving(r,coords,nextside(direction))
            if !isborder(r,direction)
                rights += 1
                direction = prevside(direction)
            end
        else
            lefts += 1
            direction = nextside(direction)
        end
    end
    if rights > lefts
        println("Я снаружи")
    else
        println("Я внутри")
    end
end
where(r)
