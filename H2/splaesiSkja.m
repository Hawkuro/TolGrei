%Forrit sem útfærir splæsibrúun meğ not-a-knot endaskilyrğum
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

    % Stikum ferilinn svo viÃ° lendum ekki Ã­ veseni
    % ef x-hnitin eru ekki Ã­ stÃ¦rÃ°arrÃ¶Ã°
    n = length(x);  t = 1:n;  tt=linspace(1,n,100);    
    
    % Reiknum og teiknum
    xx = splaesi(t,x,1,0,0,tt);
    yy = splaesi(t,y,1,0,0,tt);
    
    plot(xx,yy)