function [a,b,c,d] = splaesiStudlar(x,y,numer,df1,df2)
%
% [a,b,c,d] = splaesiStudlar(x,y,numer,df1,df2)
%
% Reiknum stuðla splæsifalls sem brúar y
% í punktunum x. Breytan numer ákvarðar gerð
% endaskilyrða:
%   numer = 1: Ekki-hnúts endaskilyrði
%   numer = 2: Þvinguð endaskilyrði - þarf að setja inn fyrir df1 og df2
%   numer = 3: Náttúrleg endaskilyrði
%   numer = 4: Lotubundin endaskilyrði
% Athugið að ef numer = 2 þarf að setja df1 = f'(x_1) og df2 = f'(x_n),
% annars má hvað sem er vera í þeirra stað.
    n = length(x);

    % Viljum bara fyrstu n-1 stökin úr y
    a = y(1:n-1);

    % Reiknum út billengdirnar
    h = x(2:n)-x(1:n-1);

    % Reiknum út mismunakvótana y[x_k,x_k+1],
    % þeir mynda megnið af hægri hlið hneppis á eftir
    z = (y(2:n)-y(1:n-1))./h(1:n-1);

    % Búum til fylkið í Ac = Y, nema fyrstu og síðustu línuna
    % því þær breytast eftir tilvikum en hitt ekki
    v(1)     = 0;       v(n)  = 0;
    v(2:n-1) = 2*(h(1:n-2)+h(2:n-1));
    h1       = h;       h2    = h;
    h1(end)  = 0;       h2(1) = 0;
    A        = zeros(n);
    A        = diag(v)+diag(h1,-1)+diag(h2,1);

    % Búum til vigurinn Y í Ac = Y, nema fyrsta og síðasta stak.
    Y        = zeros(n,1);
    Y(2:n-1) = 3*(z(2:n-1)-z(1:n-2));

    % Breytum fylkinu og vigrinum eftir tilvikum
    if (numer == 1)               % Ekki-hnúts endaskilyrði
        A(1,1)   = -h(2);         A(1,2)   = h(1)+h(2);
        A(1,3)   = -h(1);         A(n,n-2) = -h(n-1); 
        A(n,n-1) = h(n-2)+h(n-1); A(n,n)   = -h(n-2);
    elseif (numer == 2)           % Þvinguð endaskilyrði
        A(1,1)   = 2*h(1);        A(1,2)   = h(1);
        A(n,n-1) = h(n-1);        A(n,n)   = 2*h(n-1);
        Y(1) = 3*(z(1)-df1);      Y(n) = 3*(df2-z(n-1)); 
    elseif (numer == 3)           % Náttúrleg endaskilyrði
        A(1,1) = 1;  A(n,n) = 1;
    else                          % Lotubundin endaskilyrði
        A(1,1)   = 1;             A(1,n)   = -1;
        A(n,2)   = h(1);          A(n,n-1) = h(n-1);
        A(n,n)   = 2*(h(n-1)+h(1));
        Y(1) = 0;                 
        Y(n) = 3*(z(1)-z(n-1));
    end

    % Leysum fyrir c-gildin:
    c = A\Y;
    
    % Reiknum gildi b og d
    b = z(1:n-1) - (2*c(1:n-1)' + c(2:n)')/3.*h(1:n-1);
    d = (c(2:n)' - c(1:n-1)')./(3*h(1:n-1));

    % Viljum bara fyrstu n-1 stökin úr c
    c = c(1:n-1);
end