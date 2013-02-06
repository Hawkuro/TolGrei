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
	hnappur = 1;
	while hnappur == 1	
		P = square(a,b,c,d);

		[x, y, hnappur] = ginput(1);
		plot(x,y,'x');
		x0 = [ x; y];

		p = newton_gradient(f,epsilon,delta,nmax,x0,P,axiss);
		if(square_check(p,P)) 
			plot(p(1),p(2),'o')
			h1 = 0.01 * min(b-a,d-c);
			Hessian = dFgeneral(f,h1,p);
            break;
		else
			clf;
			contour(X,Y,Z,50)
            hold on
			plot(p(1),p(2),'o')
			plot(x,y,'x');
            plot(P(1,:),P(2,:),'--')
        end
    end
    if(det(Hessian) ~= 0)
        eigs = eig(Hessian);
        if(eigs(1) < 0 && eigs(2) < 0)
            %Djamm
        else
           if(eigs(1)>0 && eigs(2)>0)
              %Mega djamm
           else
             %Mega mega djamm!
           end
        end
    else
        %lame
    end

end
