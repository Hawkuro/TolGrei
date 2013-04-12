function y = lorenzODE (t,x,cond)
%%pendulODE
%Fall sem er jofnuhneppi fyrir nalgun a einfoldum pendul. tekur inn
%t sem er timaskref og x sem eru nuverandi gildi theta og theta'
    sigma = cond(1);
    r = cond(2);
    b = cond(3);
    y(1) = sigma* (x(2) - x(1));
    y(2) = x(1) * (r - x(3)) - x(2);
    y(3) = x(1)* x(2) - b*(x(3));
