function h = adams_pc5sizeofh ()
%%adams_pc5sizeofh
%A function that finds the smallest h for which the max error from
%the approximation of the function x'(t) = 
%RHS = @(t,x) -3*t*x^2 + 1/(1+t^3);
% is 10^-4
    RHS = @(t,x) -3*t*x^2 + 1/(1+t^3);
    x = @(t) t/(1+t^3);
    diff = @(x,y) abs(x-y);
    for N = 49999:1000000
        t= linspace(0,5,N+1);
        y = arrayfun(x,t);
        adms = adams_pc5(RHS,0,0,5,N);
        err = arrayfun(diff,adms,y);
        s = max(err)
        if s < 10^(-4)
            h = 1/N
            break;
        end;
    end;

%gefur h = 2.00000e-05

        
