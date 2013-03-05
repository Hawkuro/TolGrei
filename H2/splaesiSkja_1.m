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
    x=[x, x(1)];
    y=[y, y(1)];
    % Stikum ferilinn svo við lendum ekki í veseni
    % ef x-hnitin eru ekki í stærðarröð
    n = length(x);  t = 1:n;  tt=linspace(1,n,100);

    % Reiknum og teiknum
    %�arf a� reikna �t c0 og cn
    xx = splaesi(t,x,4,0,0,tt);
    yy = splaesi(t,y,4,0,0,tt);

    plot(xx,yy)
