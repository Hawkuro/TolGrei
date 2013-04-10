function y = roluODE (t,x)
    %g = 9.82;
    g = 1;
    l = 1;
    omega = sqrt(g/s(t));
    y(1) = x(2);
    y(2) = -(omega^2)*sin(x(1));

end
