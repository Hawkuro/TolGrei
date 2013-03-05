%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Nokkur forrit sem kynnt voru í fyrirlestri 9.2.2011
%
% Fyrst kemur forrit sem skilar út stuðlum 3. stigs
% splæsifalls gegnum gefna punkta.
%
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

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


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  Næsta fall tekur inn nauðsynlegar upplýsingar um 
%  brúunarverkefnið auk punktasafns xx, og skilar gildum 
%  splæsifallsins yy í punktasafninu.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function yy = splaesi(x,y,numer,df1,df2,xx)
%
%	splaesi(x,y,numer,df1,df2,xx)
%
% Reiknar splæsifallið sem brúar y í punktunum x,
% og skilar svo gildum þess í punktunum xx. Sjá
% splaesiStudlar.m fyrir útskýringu á numer, df1, df2.
% Notar fallið splaesiStudlar.
    n = length(x);
    m = length(xx);
    yy = zeros(1,m);

    % Reiknum stuðla brúunarmargliðanna
    [a,b,c,d] = splaesiStudlar(x,y,numer,df1,df2);
    
    % Metum splæsifallið í punktunum í xx
    % Breytum x lítillega svo auðveldara verði að
    % velja rétt hlutbil [x(i),x(i+1)[
    x(n) = x(n)+1;
    for i=1:m
        j = max(find(x <= xx(i)));
        tmp = xx(i)-x(j);
        yy(i) = a(j) + tmp*(b(j) + tmp*(c(j) + tmp*d(j)));
    end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Efaust virðist síðasti hluti forritsins vera svolítið undarlegur, 
% svo við skulum skoða hann aðeins nánar. Við ætlum að ganga á
%  xx  vigurinn og reikna gildi splæsifallsins í hverju staki í honum. 
% �? hverju hlutbili er splæsifallið margliða, svo þegar við höfum 
% ákvarðað á hvaða hlutbili verið erum er einfalt að finna gildi þess; 
% vandamálið snýst þá um að finna um hvaða hlutbil [x_k , x_{k+1} [
% er að ræða.
%
% Ef t  er stak í vigrinum xx ekki jafnt er x(n), þá er til tala 
% j þannig að x(j) ≤ t < x(j+1). 
% Þar x(1) < x(2) < . . . < x(n) er ljóst að j er stærsta talan þannig 
% að x(j) ≤ t; skipunin  find(x <= xx(i)) finnur alla vísa j þannig að 
% x(j) ≤ xx(i), skipunin max velur þann stærsta, og þá höfum við fundið 
% rétt hlutbil. Við lendum í smá veseni þegar t = x(n) því þar er gildi
% splæsifallsins gefið með
%
% S(x_n ) = a_{n−1} + b_{n−1} (x_n − x_{n−1} ) 
%          + c_{n−1} (x_n − x_{n−1} )^2 + d_{n−1} (x_n − x_{n−1})^3.
%
% Ef x-vigurinn væri óbreyttur, þá myndi forritið reyna að skila 
% stakinu a(n), sem er ekki til. 
% Því er x(n) hækkað  um einn svo find skipunin skili aldrei vísinum n, 
% aðeins í mesta lagi n-1,
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Best að átta sig á hvernig svona splæsiföll hegða sér með að skoða nokkrar
% myndir; þegar skráin splaesiSkja.m er keyrð les hún inn nokkra punkta af 
% skjá  og teiknar þriðja stigs splæsifall með ekki-hnúts endaskilyrðum 
% í gegnum safnið. 
% �?hugavert er að breyta endaskilyrðunum til að átta sig á muninum á þeim.
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%	splaesiSkja.m
% Les inn punkta af skjá og teiknar feril gegnum þá
% með 3. stigs splæsibrúunarfalli.
% Notar fallið splaesi.
    close all
    clear all
    
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
            x = [x, xtmp];    
            y = [y, ytmp];   
            plot(x,y,'o')
        end
    end

    % Stikum ferilinn svo við lendum ekki í veseni
    % ef x-hnitin eru ekki í stærðarröð
    n = length(x);  t = 1:n;  tt=linspace(1,n,100);    
    
    % Reiknum og teiknum
    xx = splaesi(t,x,1,0,0,tt);
    yy = splaesi(t,y,1,0,0,tt);
    
    plot(xx,yy)
    

