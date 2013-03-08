function r = R(f,a,h)
    r=[(f(a+h*[1 0]) - f(a-h*[1 0]))/(2*h);(f(a+h*[0 1]) - f(a-h*[0 1]))/(2*h)];
end