% Matlab-forrit sem les hnit punkts með músarsmelli á
%vinstri músartakka innan gefins ramma og teiknar hring
% um punktinn. Forritið stöðvar er ýtt er á hægri músartakka.
%
a=-1; b=1; c=-1; d=1;
% Mörkin sett á breyturnar
clf
% Mynd hreinsuð.
axis([a b c d])
% Mynd sett upp.
hold on
hnappur=1;
while hnappur==1
    [x,y,hnappur]=ginput(1);
    if hnappur==1
        plot(x,y,'o')
    end
end
