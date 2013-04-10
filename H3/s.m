function y = s(theta)
    l = 1;
    a = 0.2;
    omega = 2;   %athugum að við fáum inn fasahornið theta en ekki tíman 
    phi = pi;
    y = l+a*cos(omega*theta+phi);
end
