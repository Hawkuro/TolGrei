function y = pendulODE (t,x)
    g = 9.82;
    l = 1;
    y(1) = x(2);
    y(2) = -(g/l)*cos(x(1));