using HorizonSideRobots
r = Robot(animate = true)
include("custom_ functions.jl")
include("recursion_functions.jl")
mutable struct coordinates
    x :: Int
    y :: Int
end
function HorizonSideRobots.move!(coord::Coordinates,Side::HorizonSide)
    if Side == Nord
        coord.y += 1
    elseif Side == Sud
        coord.y -= 1
    elseif Side == West
        coord.x -= 1
    else
        coord.x += 1
    end
end
HSR = HorizonSideRobots
abstract type ar end
get_robot(robot::CoordsRobot) = robot.robot
HSR.move!(robot::ar,Side::HorizonSide) = move!(get_robot(robot),Side)
HSR.isborder(robot::ar,Side::HorizonSide) = isborder(get_robot(robot),Side)
HSR.putmarker!(robot::ar,Side::HorizonSide) = putmarker!(get_robot(robot),Side)
HSR.ismarker(robot::ar) = ismarker(get_robot(robot))
HSR.temperature(robot::ar) = temperature(get_robot(robot))

struct CoordsRobot <: ar
    robot :: Robot
    coord :: coordinates
end