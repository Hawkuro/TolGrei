function one_func_to_bind_them(axiss)

a=axiss(1);
b=axiss(2);
c=axiss(3);
d=axiss(4);

axis(axiss);

x = linspace(a,b,250);
y = linspace(c,d,250);

f = @(x,y) cos(x) + sin(y);

[X,Y] = meshgrid(x,y);

%Z = griddata(x,y,f,X,Y);
Z = arrayfun(f,X,Y);

contour(X,Y,Z,50)