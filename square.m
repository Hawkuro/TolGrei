function P = square(a,b,c,d)
    %Teiknum hnitakerfi
    clf;
    axis([a b c d])
    hold on
    hnappur = 1;
    i = 1;
    P = [ 0 0 0 0 0; 0 0 0 0 0];
    while hnappur == 1;
            [x,y,hnappur] = ginput(1);
                if hnappur == 1 && i <= 4;
                P(1,i) = x;
                P(2,i) = y;
                plot(x,y,'o');
                i = i+1;
            end
    P(1,5) = P(1,1);
    P(2,5) = P(2,1);
end
            
