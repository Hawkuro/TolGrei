function y = kulupendulODE(t,x)
    m = 1;
    l = 1;
    g = 1;
    om = 1/(m*l*l);
    
    y(1) = om*x(3);
    y(2) = om*x(4)/(sin(x(1))^2);
    y(3) = om*x(4)^2*(cos(x(1))/(sin(x(1))^3)) - m*l*g*sin(x(1));
    y(4) = 0;