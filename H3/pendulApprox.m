function y = pendulApprox(x_0)
%%pendulApprox
%Forrit sem gerir nalgun a pendul fra 0 upp i 5 med upphafsgildin
%i x_0, [theta0,theta1] 
    y = adams_pc5('pendulODE',0,x_0,5,100);