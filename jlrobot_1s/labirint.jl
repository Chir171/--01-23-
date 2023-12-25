using HorizonSideRobots
include("custom_ functions.jl")
r = Robot("C:/Users/Александр/Desktop/untitled.sit";animate = true)
function mark_labirint!(r::Robot,prev_side::HorizonSide)
        for side in (Nord, West, Sud, Ost)
            if side != prev_side
                if try_move!(r,side)
                    mark_labirint!(r,inverse(side))
                    move!(r, inverse(side))
                end
            end
        end
end
mark_labirint!(r,Sud)