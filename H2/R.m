function r = R(f,a,h,n)
    r=0;
    for i=0:n
        r = r + h*f(a+i*h);
    end
    r = r - h/2*(f(a) + f(a+n*h));
end