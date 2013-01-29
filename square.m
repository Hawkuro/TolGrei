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
    
    P = sortRectangle(P)

end

%Skiptir a dalkum a og b i 2xN fylki
function P = swapColums(P,a,b)
    temp1 = P(1,a);
    temp2 = P(2,a);
    P(1,a) = P(1,b);
    P(2,a) = P(2,b);
    P(1,b) = temp1;
    P(2,b) = temp2;
end

%Finnur staersta stak i linu c i fylki P
function maxX = maxBy(P,c,from, to)
    maxX = from;
    i = from;
    while i <= to;
        if P(c,i) >= P(c,maxX);
            maxX = i;
        end
        i = i+1;
    end
end

%Finnur minnsta stak i linu c i fylki P
function minX = minBy(P,c,from, to)
    minX = from;
    i = from;
    while i <= to;
        if P(c,i) <= P(c,minX);
            minX = i;
        end
        i = i+1;
    end
end

%Radar punktum ferhyrnings thannig ad vigrarnir milli p_n og p_n+1 seu rettsaelis,
%P_5 = P_1
function P = sortRectangle(P)
    if paralell(P,4) == 0;
        %Setjum tha i retta rod
        P = swapColums(P,1,minBy(P,1,1,4));
        P = swapColums(P,2,maxBy(P,2,2,4));
        P = swapColums(P,3,maxBy(P,1,3,4));
        % 4. punkturinn er þegar a rettum stad
    else
       P = swapColums(P,1,minBy(P,1,1,4));
       P = swapColums(P,2,minBy(P,1,2,4));
       P = swapColums(P,1,minBy(P,2,1,2));
       P = swapColums(P,3,maxBy(P,2,3,4));
    end

    %Latum P_5 = P_1
    P(1,5) = P(1,1);
    P(2,5) = P(2,1);
end

%athughar hvort kassinn se med hlidar samsida asum, ad k
function b = paralell(P,k)
    b = 0;
    i = 1;

    while i <= k;
        if P(1,1) == P(1,k)
            b=1;
        end
        i = i+1;
    end
end 



