%Tekur inn hnit med musasmellum og skilar fylki med theim i rettri rod.
function P = square(a,b,c,d)
    %Teiknum hnitakerfi
    clf;
    axis([a b c d])
    hold on
    hnappur = 1;
    i = 1;
    %Buum til fylki til að geyma niðurstöður.
    P = [ 0 0 0 0 0; 0 0 0 0 0];
    while hnappur == 1;
        [x,y,hnappur] = ginput(1);
        %Viljum bara fá 4 punkta.
        if hnappur == 1 && i <= 4;
            P(1,i) = x;
            P(2,i) = y;
            plot(x,y,'o');
            i = i+1;
        end
    end
    
    P = sortRect(P);
    plot(P(1,:),P(2,:))

end

function P = sortRect(P)
    ch = convhull(P(1,1:4)',P(2,1:4)');
    temp = zeros(2,5);
    for i = 1:5
        temp(1,i) = P(1,ch(6-i));
        temp(2,i) = P(2,ch(6-i));
    end
    P = temp;
end


