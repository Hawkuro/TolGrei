function y = roluODEmax (t,x)
    % jofnuhneppi sem lysir rolu sem eykur sveifluna sem mest
    g = 1;
    l = 1;
    utslag = 0.8; 
    horntidni = sqrt(g/l)/(2*pi*(1+ (x(2)^2)/16 + (x(2)^4)*11/3072));
    fasahlidrun = pi;
    s = @(t) l + utslag*cos(horntidni * t + fasahlidrun);
    
    y(1) = x(2);
    y(2) = -(g/s(t))*sin(x(1));

end
