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
end