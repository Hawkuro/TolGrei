%Tekur inn hnit med musasmellum og skilar fylki med theim i rettri rod.
function P = square(a,b,c,d)
    %Teiknum hnitakerfi
    axis([a b c d])
    hold on
    hnappur = 1;
    i = 1;
    %Buum til fylki til að geyma niðurstöður.
    %P = [ 0 0 0 0 0; 0 0 0 0 0];
    %Fylki er buid til sjalfkrafa
    while hnappur == 1 && i <= 4;
        [x,y,hnappur] = ginput(1);
        %Viljum bara fá 4 punkta.
        if hnappur == 1;
            P(1,i) = x;
            P(2,i) = y;
            plot(x,y,'o');
            i = i+1;
        end
    end
    if i <= 4
        %Getum notad thetta til ad akvarda hvort haegri klikk kom.
        P = [];
        return
    end
    %Possum ad vid hofum fengid nogu marga punkta
    if length(unique(P.','rows')) >= 4
        P = P(:,flipdim(convhull(P(1,1:4)',P(2,1:4)'),1));
        plot(P(1,:),P(2,:))
        %Possum ad vid seum med kassa en ekki t.d. Thrihyrning
        if length(P) < 5 
            P = square(a,b,c,d);
        end
    else
        %Ef ekki bidjum vid um nyjan kassa
        P = square(a,b,c,d);
   end
end


