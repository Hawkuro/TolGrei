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

    while hnappur==1
        [xtmp,ytmp,hnappur]=ginput(1);
        if hnappur==1
            x = [x, xtmp];
            y = [y, ytmp];
            plot(x,y,'o')
        end
    end
    
    df1x = (x(1)-x(end-1));
    df1y = (y(1)-y(end-1));
    df2x = (x(end) - x(end-2));
    df2y = (y(end) -y(end-2));
    x = x(1:end-2);
    y = y(1:end-2);
    
    % Stikum ferilinn svo við lendum ekki í veseni
    % ef x-hnitin eru ekki í stærðarröð
    n = length(x);  t = 1:n;  tt=linspace(1,n,100);

    % Reiknum og teiknum
    %Þarf að reikna út c0 og cn
    xx = splaesi(t,x,2,df1x,df2x,tt);
    yy = splaesi(t,y,2,df1y,df2y,tt);
    
    plot(xx,yy)