function y = pendulODE (t,x)
    %g = 9.82;
    g = 1;
    l = 1;
    omega = sqrt(g/l);
    y(1) = x(2);
    %y(2) = -(omega^2)*sin(x(1));
    % prufa linulega nalgun
    y(2) = -(omega^2)*x(1);
