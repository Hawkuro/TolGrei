function y = roluODE (t,x)
    %g = 9.82;
    g = 1;
    l = 1;
    utslag =  0.1;
    horntidni = 1;
    fasahlidrun = pi;
    s = @(t) l + utslag*cos(horntidni * t + fasahlidrun);
    y(1) = x(2);
    y(2) = -(g/s(t))*sin(x(1));

end
