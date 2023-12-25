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
function start_pos(r)
    if length(bc(r)[2]) != 2
        return
    end
    points = 0
    coords = [0,0]
    direction = bc(r)[2][1]
    max_height = [0,0]
    while points <= 4
        if coords == [0,0]
            points += 1
        end
        if points >= 4
            break
        end
        if try_move!(r,nextside(direction))
            coords = coords_moving(r,coords,nextside(direction))
            if length(bc(r)[2]) == 3
                return
            end
            if coords[2] > max_height[2] && isborder(r,Sud)
                max_height = coords
            end
            if !isborder(r,direction)
                direction = prevside(direction)
            end
        else
            direction = nextside(direction)
        end
    end
    while coords != max_height
        if try_move!(r,nextside(direction))
            coords = coords_moving(r,coords,nextside(direction))
            if !isborder(r,direction)
                direction = prevside(direction)
            end
        else
            direction = nextside(direction)
        end
    end
    return 1
end
function ploshad(r::Robot)
    pl = 0
    coords = [0,0]
    par = 0
    if start_pos(r) == 1
        direction = Sud
    else
        direction = bc(r)[2][1]
    end
    while coords != [0,0] || par == 0
        par += 1
        if isborder(r,Nord) && direction == Nord 
            pl = pl - coords[2] - 1
        else
            if isborder(r,Sud) && direction == Sud
                pl = pl + coords[2]
            end
        end
        if try_move!(r,nextside(direction))
            coords = coords_moving(r,coords,nextside(direction))
            if !isborder(r,direction)
                direction = prevside(direction)
            end
        else
            direction = nextside(direction)
        end
    end
    println(pl)
end
ploshad(r)
