function [adms, err] = adams_pc5plot (N)
%%adams_pc5plot
%A function that approximates x'(t) = 
%RHS = @(t,x) -3*t*x^2 + 1/(1+t^3)
%And plots the real function in addition to the approximation, and
%a graph of the error
    RHS = @(t,x) -3*t*x^2 + 1/(1+t^3)
    t = linspace(0,5,N+1);
    x = @(t) t/(1+t^3);
    y = arrayfun(x,t);
    plot(t,y)
    hold on
    adms = adams_pc5(RHS,0,0,5,N)
    diff = @(x,y) abs(x-y)
    err = arrayfun(diff,adms,y)
    plot(t, adms,'r--')
    figure()
    plot(t,err)