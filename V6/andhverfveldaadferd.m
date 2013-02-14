function lambda = andhverfveldaadferd(A,q,x,eps)
    [L,U] = lu(A-q*eye(size(A)));
    y = U\(L\x);
    n =y(find(abs(y)==norm(y,Inf),1));
    x = y/n
    lambda = 1/n + q
    while 1
        y = U\(L\x);
        n =y(find(abs(y)==norm(y,Inf),1));
        %Finnum inf-normid med minnsta indexid.
        x = y/n
        oldlambda = lambda;
        lambda = 1/n + q
        if abs(lambda-oldlambda) <= eps
            break
            end
    end
end
