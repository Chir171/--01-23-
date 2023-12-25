using HorizonSideRobots
r = Robot("sp/n1-4.sit";animate = true)
inverse(Side::HorizonSide) = HorizonSide(mod(Int(Side)+2,4))
function tl_corner()
    step_hz = 0
    step_ver =0
    while !isborder(r,Nord)
        move!(r,Nord)
        step_ver += 1
    end
    while !isborder(r,West)
        move!(r,West)
        step_hz += 1
    end
    return [step_hz,step_ver]
end
function line(Side_hz::HorizonSide,Side_ver::HorizonSide)
    while !isborder(r,Side_hz)
        putmarker!(r)
        move!(r,Side_hz)
    putmarker!(r)
    end
    if !isborder(r,Side_ver)
        move!(r,Side_ver)
    end
end
function snake_tl()
    i = Ost::HorizonSide
    while !isborder(r,Sud) || (isborder(r,Sud) && !isborder(r,Ost))
        line(i,Sud)
        i = inverse(i)
    end
end
function go_to(Side_hz,num_steps_hz,Side_ver,num_steps_ver)
    for i in 1:num_steps_hz
        move!(r,Side_hz)
    end
    for i in 1:num_steps_ver
        move!(r,Side_ver)
    end
end
function n4()
    q = tl_corner()
    x = q[1]
    y = q[2]
    snake_tl()
    tl_corner()
    go_to(Ost,x,Sud,y)
end
n4()