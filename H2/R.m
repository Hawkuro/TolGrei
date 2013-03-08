function r = R(f,a,h)
    A = (f(a + h*[1 0]) +f(a-h*[1 0]) - 2*f(a))/(h*h);
    C = (f(a + h*[0 1]) +f(a-h*[0 1]) - 2*f(a))/(h*h);
    B = (f(a + h*[1 0] + h*[0 1]) - f(a + h*[1 0] - h*[0 1]) - f(a - h*[1 0] + h*[0 1]) + f(a - h*[1 0] - h*[0 1]))/(4*h*h);
    r=[A B; B C];
end