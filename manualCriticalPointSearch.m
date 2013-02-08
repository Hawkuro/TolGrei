function manualCriticalPointSearch(f,axiss,epsilon,delta,nmax)
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
       
        %Vid faum P = [] ef vid haettum i midri keyrslu, t.d. ef
        %smellt er a haegri hnapp.
        if length(P) == 0
            return
        end
        
        [x, y, hnappur] = ginput(1);
        if hnappur ~= 1
            return
        end
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
            M = det(Hessian);

            %Ef M er svona litid, tha er determinant fylkisins
            %ansi nalgaegt thvi ad vera 0, og er thvi ekki
            %haegt ad not thad i reikningum. Tha er heldur ekki
            %haegt ad segja neitt um thann punkt, thannig ad
            %vid sleppum honum bara
            if abs(M) < epsilon
                fprintf('Ekki hægt að segja til um (x,y) = (%f,%f)\n',p(1),p(2))
                plot(p(1),p(2),'o')
                continue
            end

            if(M > 0)
                eigs = eig(Hessian);
                if eigs(1) > 0 && eigs(2) > 0
                    fprintf('Lágpunktur í (x,y) = (%f,%f), f(x,y) = %f\n',p(1),p(2),f(p(1),p(2)))
                    plot(p(1),p(2),'v')
                    fprintf('Gildi: %f\n',f(p(1),p(2)))
                else
                    if eigs(1) < 0 && eigs(2) < 0
                    fprintf('Hápunktur í (x,y) = (%f,%f), f(x,y) = %f\n',p(1),p(2),f(p(1),p(2)))
                        plot(p(1),p(2),'^')
                        fprintf('Gildi: %f\n', f(p(1),p(2)))
                    end
                end
            else
                if M < 0
                    fprintf('Söðulpunktur í (x,y) = (%f,%f)\n',p(1),p(2))
                    plot(p(1),p(2),'*')
                end
            end
       else
            fprintf('Enginn punktur fannst innan kassans\n');
        end
    end
    
end
