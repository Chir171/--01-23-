using HorizonSideRobots
r = Robot("C:/Users/Александр/Desktop/untitled.sit";animate = true)
HSR = HorizonSideRobots
include("custom_ functions.jl")
abstract type Arobot end

HSR.putmarker!(robot::Arobot) = putmarker!(gbs(robot))
HSR.move!(robot::Arobot,side::HorizonSide) = move!(gbs(robot),side), putmarker!(gbs(robot))
HSR.isborder(robot::Arobot,side::HorizonSide) = isborder(gbs(robot),side)
HSR.temperature(robot::Arobot) = temperatue(gbs(robot))
HSR.ismarker(robot::Arobot) = ismrarker(gbs(robot))

mutable struct Coordinates 
    x::Int
    y::Int
end

function HSR.move!(coord::Coordinates,side::HorizonSide)
    if side == Nord
        coord.y += 1
    end
    if side == Sud
        coord.y -= 1
    end
    if side == West
        coord.x -= 1
    end
    if side == Ost
        coord.x += 1
    end
end

struct Coord_Robot <: Arobot
    robot::Robot
    coord::Coordinates
end 

gbs(robot::Coord_Robot) = robot.robot

pos(robot::Coord_Robot) = robot.coord

function HSR.move!(robot::Coord_Robot,side::HorizonSide)
    move!(robot.coord,side)
    move!(robot.robot,side)
end

function try_move!(robot::Coord_Robot,side::HorizonSide)
    if !isborder(robot.robot,side)
        move!(robot,side)
        return true
    else
        return false
    end
end

mutable struct Border_Robot <: Arobot
    robot::Coord_Robot
    right::Int
    left::Int 
end

gbs(robot::Border_Robot) = robot.robot

function HSR.move!(robot::Border_Robot,border_side::HorizonSide)
    if try_move!(robot.robot,nextside(border_side))
        if !isborder(robot.robot,border_side)
            robot.right += 1
            return prevside(border_side)
        else
            return border_side
        end
    else
        robot.left += 1
        return nextside(border_side)
    end
end

function where(robot::Robot,border_side::HorizonSide)
    br = Border_Robot(Coord_Robot(robot,Coordinates(0,0)),0,0)
    one(br,border_side,0,0)
    if br.right > br.left
        println("snaruji")
    else
        println("vnutri")
    end
end

function s(robot::Robot,border_side::HorizonSide)
    br = Border_Robot(Coord_Robot(robot,Coordinates(0,0)),0,0)
    A = one(br,border_side,0,0)
    s = 0
    for i in A
        if i[3] == Nord
            s = s - 1 - i[2]
        end
        if i[3] == Sud
            s = s + i[2]
        end
    end
    return s
end

function one(robot::Border_Robot,border_side::HorizonSide,x_stop::Int,y_stop::Int)
    dots = [[0,0,border_side]]
    par = move!(robot,border_side)
    start = border_side
    border_side = par
    hod = 0
    while robot.robot.coord.x != x_stop || robot.robot.coord.y != y_stop || border_side != start || hod == 0
        if robot.robot.coord.x != 0 || robot.robot.coord.y != 0
            hod = 1
        end
        if isborder(robot.robot.robot,border_side)
            push!(dots,[robot.robot.coord.x,robot.robot.coord.y,border_side])
        end
        par = move!(robot,border_side)
        border_side = par
    end
    return dots
end

println(s(r,Nord))
