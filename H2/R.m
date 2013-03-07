function r = R(f,a,h)
    r = (f(a+h) + f(a-h) - 2*f(a))/(h*h);
end