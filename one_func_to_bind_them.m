function one_func_to_bind_them(axiss,epsilon,delta,nmax)
	a=axiss(1);
	b=axiss(2);
	c=axiss(3);
	d=axiss(4);

	axis(axiss);
    
    f = @(x,y) func(x,y);

	x = linspace(a,b,250);
	y = linspace(c,d,250);
    
	[X,Y] = meshgrid(x,y);

	clf;
	Z = arrayfun(f,X,Y);

	contour(X,Y,Z,50)

	hold on

	[P,x0]=square(a,b,c,d);
    
    c = newton_gradient(f,epsilon,delta,nmax,x0,P,axiss);
    plot(c(1),c(2),'o')
end
