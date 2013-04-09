function y = adams_pc5plot (N)
    RHS = @(t,x) -3*t*x^2 + 1/(1+t^3)
    t = linspace(0,5,N+1)
    x = @(t) t/(1+t^3);
    y = arrayfun(x,t);
    plot(t,y)
    hold on
    plot(t,adams_pc5(RHS,0,0,5,N),'r--')