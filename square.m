%Tekur inn hnit med musasmellum og skilar fylki med theim i rettri rod.
function [P x0] = square(a,b,c,d)
    %Teiknum hnitakerfi
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
    
    P = P(:,flipdim(convhull(P(1,1:4)',P(2,1:4)'),1));
    test = P(:,5); %T�kkar hvort convhull gefi fj�ra punkta, og �v� hvort ferhyrningurinn s� k�ptur.
    plot(P(1,:),P(2,:))
    [x, y, hnappur] = ginput(1);
    plot(x,y,'x');
    x0 = [ x; y];
end


