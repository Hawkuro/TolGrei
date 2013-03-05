function yy = baz( y, tt)   
    for i=1:length(tt)
        t=tt(i);
        yy(i)=(1-t)^3*y(1)+3*(1-t)^2*t*y(2)+3*(1-t)*t^2*y(3)+t^3*y(4);
    end
end