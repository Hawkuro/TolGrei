function c = minnstu_fervik(x,y,n)
%
%    c = minnstu_fervik(x,y,n)
%
% Forriti� skilar stu�lum n-ta stigs margli�u sem 
% gefur bestu n�lgun � gefin g�gn x, y. Ef ekkert 
% n er gefi� gerum vi� r�� fyrir a� �a� s� �ska� 
% eftir bestu l�nu. Athugi� a� x og y ver�a a� vera
% d�lkvigrar, annars virkar forriti� ekki.
% Skilar:
%   c - vigur me� stu�lum bestu margli�u
%       sem br�ar g�gnin x, y. H�r er
%       c(k) staki� c_k �
%       p(x) = c_1 + c_2 x + ... + c_(n+1) x^n
    if (nargin == 2), n = 1; end
    m = length(x);    
    
    % Stu�lafylki� er A = (a_{ij}), a_{ij} = x_i^{j-1}
    % Vi� leitum a� bestu margli�u af stigi n e�a l�gri
    % og �v� eru grunnfullin n+1 talsins.
    A = zeros(m,n+1);
    A(1:m,1)=ones(m,1);
    A(1:m,2)=x;
    for j=3:n+1
        A(1:m,j)=A(1:m,j-1).*x;
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

