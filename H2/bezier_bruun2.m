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
    n=2;
    t=1:n;
    tt=linspace(1,n,100);

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
            xx = splaesi(t,x(2:3),2,df1x,df2x,tt);
            yy = splaesi(t,y(2:3),2,df1y,df2y,tt);
            plot(xx,yy)
            
            x = [(2*x(3)-x(4)) x(3)];
            y = [(2*y(3)-y(4)) y(3)];
        end
    end