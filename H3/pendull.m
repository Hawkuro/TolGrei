%% pendull.m
% Skipanaskra sem byr til hreyfimynd af einfoldum penduli
aviobj = avifile('pendull.avi','compression','None','fps',16); %#ok<REMFF1>
% Segir til um nafn myndbandsins, þjoppun og fjolda ramma a sek.
% Windows notendur aettu ad breyta 'None' i 'Indeo5' eda i einhvern annan
% compression moguleika.
% Mac, Linux, BSD og onnur styrikerfi thurfa ad thjappa myndbandid
% handvirkt utan matlab, t.d med ffmpeg.
fig=figure;
%% Fastar
lotur = 5;          %Fjoldi lota til að reikna
n = 25;             %Fjoldi mynda i hverri lotu               
theta0 = 1;         %theta(t0)
theta1 = 0;         %theta'(t0)
omega = 1;          %Hornhradi
t0 = 0;
%% Jofnurnar
theta = @(t) theta0*cos(omega*(t-t0)) + (theta1/omega) * sin(omega*(t-t0));
dtheta = @(t) -omega*theta0*sin(omega*(t-t0))+ theta1*cos(omega*(t-t0));
%%
% Thar sem við hreinsum myndina i hverju skrefi ta thurfum vid ad geyma
% fasahnitin i fylki
fasahnit = [theta(0);dtheta(0)];
for t = 0:2*pi/n:2*pi*lotur
    %% Pendullinn    
    subplot(2,1,1) %Skiptir myndaflotinum i 2x1 fylki og segir matlab ad nota fyrsta stakid
    % Teikniskipun fyrir pendulinn: teiknum linu fra [0,0] (festipunktur) 
    % i [sin(theta(t)),-cos(theta(t))] sem er stadsetning lodsins
    % '-o' segir ad vid aetlum ad teikna linu med hringlaga endapunkta
    % 'MarkerSize' setur staerd endapunktanna
    % 'MarkerFaceColor' akvardar lit endapunktana
    plot([0,sin(theta(t))],[0,-cos(theta(t))],'-o','MarkerSize',8,'MarkerFaceColor','r') 
    axis([-1.2,1.2,-1.2,1.2]) %Festir asana
    axis square %Thvingar matlab til ad hafa x og y asinn jafn langan
    %% Fasaritid
    subplot(2,1,2) %Skipar matlab ad nota seinni hlutan af myndflotinum
    fasahnit = [fasahnit(1,:) theta(t);fasahnit(2,:) dtheta(t)]; %Baetir nyju fasahnitunum vid thau gomlu.
    plot(fasahnit(1,:),fasahnit(2,:)) % Linan i fasaritinu
    hold on % Thurfum ad setja "hold on" her svo vid yfirskrifum ekki linuna i fasaritnu bara med punktinum
    plot(theta(t),dtheta(t),'or', 'MarkerSize', 6) %Punkturinn i fasaritinu
    axis([-1.2,1.2,-1.2,1.2])
    axis square
    hold off 
    %% Hreyfimynd
    F = getframe(fig); %Naer i nyjasta ramman
    aviobj = addframe(aviobj,F); % Og skeytir thvi vid restina
end
%% Fragangur
close(fig); %Lokar myndinni til að ekki se haegt að yfirskrifa hana
aviobj = close(aviobj); %Lokar og byr til myndbandid