function one_func_to_bind_them(f,axiss,epsilon,delta,nmax)
	a=axiss(1);
	b=axiss(2);
	c=axiss(3);
	d=axiss(4);

	axis(axiss);
    
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
        
        while (square_check(x0,P) ~= 1)
            [x, y, hnappur] = ginput(1);
            plot(x,y,'x');
            x0 = [ x; y];
        end
		
        
        
        p = newton_gradient(f,epsilon,delta,nmax,x0,P,axiss);
        if(square_check(p,P)) 
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
    
    M = det(Hessian);
    if(M > 0)
        eigs = eig(Hessian);
<<<<<<< HEAD
        if eigs(1) > 0 && eigs(2) > 0
            %lagpunktur
            plot(p(1),p(2),'v')
        else
            if eigs(1) < 0 && eigs(2) < 0
                %hapunktur
                plot(p(1),p(2),'^')
            end
=======
        if(eigs(1) < 0 && eigs(2) < 0)
            %Djamm
        else
           if(eigs(1)>0 && eigs(2)>0)
              %Mega djamm
           else
             %Mega mega djamm!
           end
>>>>>>> 71d0ff776ef910f29e80cc872647aed92841427f
        end
    else
        if M < 0
            %Sodulpunktur
            plot(p(1),p(2),'*')
        else
            %Test inconclusive
            plot(p(1),p(2),'o')
        end
    end
end
