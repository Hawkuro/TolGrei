% x''(t) + g*sin(x(t))/l = 0
% x''(t) = -g * sin (x(t)) = 0
% x'(t) = (-g/l) \int sin(x(t)) = 0
%(d cos(x(t))/ dt = -sin(x(t)) x'(t))
% x'(t)^2 = (g/l) cos(x(t))
% x'(t) = sqrt((g/l) * cos(x(t))

function y = pendulODE (t,x)
    g = 9.82;
    l = 1;
    y = sqrt((g/l)*cos(x));