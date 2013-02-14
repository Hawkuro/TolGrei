function x = veldaadferd()
    A = [3 2 -2; -3 -1 3; 1 2 0];
    x0 = [1;0;0];
    veldaadferdworker(A,x0,5)
end

function lambda = veldaadferdworker(A,x,m)
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