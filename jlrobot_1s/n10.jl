using HorizonSideRobots
r = Robot("C:/Users/Александр/Desktop/untitled.sit";animate = true)
inverse(Side::HorizonSide) = HorizonSide(mod(Int(Side)+2,4))
nextside(Side::HorizonSide) = HorizonSide(mod(Int(Side)+1,4))
prevside(Side::HorizonSide ) = HorizonSide(mod(Int(Side)-1,4))
function corner(Vertical,Horizontal)
    moves = []
    while !isborder(r,Horizontal) || !isborder(r,Vertical)
        if !isborder(r,Horizontal)
            move!(r,Horizontal)
            push!(moves,inverse(Horizontal))
        else
            move!(r,Vertical)
            push!(moves,inverse(Vertical))
        end
    end
    return reverse(moves)
end
function step_instruction(moves::Array)
    for i in moves
        move!(r,i)
    end
end
function chess_lines(Size,counter)
    if counter == 1
        counter = 0
    else
        counter = Size
    end
    while !isborder(r,Nord)
        if mod(div(counter,Size),2) == 0
            putmarker!(r)
        end
        if !isborder(r,Nord)
            move!(r,Nord)
        else
            break
        end
        counter += 1
    end
    if mod(div(counter,Size),2) == 0
        putmarker!(r)
    end
    while !isborder(r,Sud)
        move!(r,Sud)
    end
    if !isborder(r,Ost)
        move!(r,Ost)
    else
        return
    end
end
function n10(Size)
    map = corner(Sud,West)
    counter = 0
    while !isborder(r,Ost)
        chess_lines(Size,mod(div(counter,Size),2) == 0)
        counter += 1
    end
    chess_lines(Size,mod(div(counter,Size),2) == 0)
    corner(Sud,West)
    step_instruction(map)
end
n10(3)