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
function line(Side)
    counter = 0
    flag = 0
    long_flag = 0
    while !isborder(r,Side)
        if isborder(r,Nord)
            if flag == 0 && long_flag == 0
                counter += 1
            end
            long_flag = flag
            flag = 1
        else
            long_flag = flag
            flag = 0
        end
        move!(r,Side)
    end
    return counter
end
function snake(Vertical,Horizontal)
    counter = 0
    while !isborder(r,Vertical)
        counter += line(Horizontal)
        move!(r,Vertical)
        Horizontal = inverse(Horizontal)
    end
    return counter
end
function n12()
    path = corner(Sud,West)
    ans = snake(Nord,Ost)
    corner(Sud,West)
    step_instruction(path)
    println(ans)
end
n12()