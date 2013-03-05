function c = minnstu_fervik()
    m = length(x);    
    x=[0,0.4,0.7,0.6,1];
    y=[1.22,0.53,0.34,0.72,1.22];
    A = zeros(m,n+1);
    for j=1:m
        A(i,:)=[1 , x(i)*(1-x(i)) , exp(x(i))];
    end  

    % Reiknum �r j�fnuhneppinu A^TAc=A^Ty: 
    c = (A'*A)\(A'*y);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function v = horner(c,x,a);
%
% function v = horner(c,x,a)
%
% Falli� reiknar �t gildi margli�unnar
%    p(x) = c(1) + c(2)(x-x(1)) + ... + c(m)(x-x(1))*...*(x-x(m-1))
% � punktunum a_1, ..., a_n.
    m = length(c); n = length(a);
    v = c(m)*ones(1,n);

    for i=m-1:-1:1
        v = c(i) + v .* (a - x(i));
    end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function fervikSkja(n)
%
% Les inn punkta af skj� og og teiknar bestu margli�u
% af stigi n gegnum ��. Ef ekkert n er gefi� teiknar
% forriti� bestu l�nu gegnum punktana.
    close all
    
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
            x = [x; xtmp];    
            y = [y; ytmp];   
            plot(x,y,'o')
        end
    end
    
    if (nargin==0)
        n = 1; 
    end
    
    % Reiknum margli�una
    c = minnstu_fervik(x,y,n);
    xx = linspace(a,b);
    yy = horner(c,0,xx);
    
    plot(xx,yy)

