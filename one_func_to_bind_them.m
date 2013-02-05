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


	Z = arrayfun(f,X,Y);
    
    clf;

	contour(X,Y,Z,50)

	hold on
    
	[P,x0]=square(a,b,c,d);
    
    p = newton_gradient(f,epsilon,delta,nmax,x0,P,axiss);
    plot(p(1),p(2),'o')
    
    h1 = 0.01 * min(b-a,d-c);
    Hessian = dFgeneral(f,h1,p)
end
