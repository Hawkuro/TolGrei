function automaticCriticalPointSearch(f,axiss,epsilon,delta,nmax,boxes)
    a=axiss(1);
    b=axiss(2);
    c=axiss(3);
    d=axiss(4);

    axis(axiss);
    
    xspace = linspace(a,b,250);
    yspace = linspace(c,d,250);
    
    [X,Y] = meshgrid(xspace,yspace);


    Z = arrayfun(f,X,Y);
    
    clf;
    contour(X,Y,Z,50)
    hold on
    
    i = 1;
    j = 1;
    
    x = linspace(a,b,boxes);
    y = linspace(c,d,boxes);
     
    while i < boxes
       while j < boxes 
            P = [ x(i) x(i) x(i+1) x(i+1) x(i); ...
                  y(j) y(j+1) y(j+1) y(j) y(j)];
            plot(P(1,:),P(2,:))
	    x0 = [ (x(i) + x(i+1))*0.5; (y(j) + y(j+1))*0.5];
            try
                p = newton_gradient(f,epsilon,delta,nmax,x0,P, ...
                                    axiss);
            catch err
                continue
            end
            
	    if(square_check(p,P)) 
		h1 = 0.01 * min(b-a,d-c);
		Hessian = dFgeneral(f,h1,p);
		M = det(Hessian);
                
                %Ef M er svona litid, tha er determinant fylkisins
                %ansi nalgaegt thvi ad vera 0, og er thvi ekki
                %haegt ad not thad i reikningum. Tha er heldur ekki
                %haegt ad segja neitt um thann punkt, thannig ad
                %vid sleppum honum bara
                if abs(M) < epsilon
                    j = j+1;
                    fprintf('Ekki hægt að segja til um (x,y) = (%f,%f)\n',p(1),p(2))
                    plot(p(1),p(2),'o')
                    continue
                end
                
		if(M > 0)
		    eigs = eig(Hessian);
		    if eigs(1) > 0 && eigs(2) > 0
                        fprintf('Lágpunktur í (x,y) = (%f,%f), f(x,y) = %f\n',p(1),p(2),f(p(1),p(2)))
                        plot(p(1),p(2),'v')
                    else
                        if eigs(1) < 0 && eigs(2) < 0
                            fprintf('Hápunktur í (x,y) = (%f,%f), f(x,y) = %f\n',p(1),p(2),f(p(1),p(2)))
                            plot(p(1),p(2),'^')
                        end
		    end
		else
		    if M < 0
			fprintf('Söðulpunktur í (x,y) = (%f,%f)\n',p(1),p(2))
			plot(p(1),p(2),'*')
		    end
		end
	    end
	    j = j+1;
	end
	i = i +1;
        j = 1;
    end 
end
