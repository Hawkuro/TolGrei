% Notar fallið splaesi.
    close all
    clear all

    % Setjum mynd upp
    a=-1; b=1; c=-1; d=1;
    axis([a b c d])

    % Lesum inn punkta
    hold on
    hnappur=1;
    x = []; y = [];
    n=4;
    t=0:1;
    tt=linspace(0,1,100);
    xxx = []; %Hehe
    yyy = [];

    while hnappur==1
        [xtmp,ytmp,hnappur]=ginput(1);
        if hnappur==1
            x = [x, xtmp];
            y = [y, ytmp];
            plot(x,y,'o')
        end        
        if hnappur==1&length(x) == 4
            df1x = (x(2)-x(1));
            df1y = (y(2)-y(1));
            df2x = (x(4) - x(3));
            df2y = (y(4) - y(3));
            plot([x(2) x(1)], [y(2) y(1)], 'r')
            plot([x(4) x(3)], [y(4) y(3)], 'r')
            xx = baz(x,tt);
            xxx = [xxx xx];
            yy = baz(y,tt);
            yyy = [yyy yy];
            plot(xx,yy)
            
            x = [x(4) (2*x(4)-x(3))];
            y = [y(4) (2*y(4)-y(3))];
        end
    end
    
        
    close all
    a=-1; b=1; c=-1; d=1;
    axis([a b c d])

    % Lesum inn punkta
    hold on
    plot(xxx,yyy)