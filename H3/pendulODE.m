function y = pendulODE (t,x)
%%pendulODE
%Fall sem er jofnuhneppi fyrir nalgun a einfoldum pendul. tekur inn
%t sem er timaskref og x sem eru nuverandi gildi theta og theta'
    g = 1;
    l = 1;
    omega = sqrt(g/l);
    y(1) = x(2);
    y(2) = -(omega^2)*sin(x(1));
