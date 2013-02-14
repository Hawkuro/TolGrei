function lambda = veldaadferd(A,x,m)
    i = 0;
    x %Prentum ut x^(0), til ad sja rununa.
    while i < m
        y = A*x;
        %Finnum inf-normid med minnsta indexid.
        x = y/y(find(abs(y)==norm(y,Inf),1))
        i = i+1;
    end
    %Viljum finna eigingildid lika, til thess er adferdin
    lambda = y(find(abs(y)==norm(y,Inf),1));
end