%%adams_pc5test
%a function that test the adams_pc5 function 
%that approximates x'(t) = 
%RHS = @(t,x) -3*t*x^2 + 1/(1+t^3)
adams_pc5('RHS', 0, 0, 5, 100)