function y = pendull3d(RHS,lotur,n,x0,t0,res)
%% pendull.m
% Skipanaskra sem byr til hreyfimynd af einfoldum penduli, tekur
% inn ODE pendulsins sem RHS, hve margar lotur, hve margar myndir per lotu, upphafsgildin
% theta0,theta1, omega og t0, og hve margrfaltfleiri itranir af
% nalgun eru en rommum.
aviobj = avifile('pendull.avi','compression','None','fps',16); %#ok<REMFF1>
% Segir til um nafn myndbandsins, thjoppun og fjolda ramma a sek.
% Windows notendur aettu ad breyta 'None' i 'Indeo5' eda i einhvern annan
% compression moguleika.
% Mac, Linux, BSD og onnur styrikerfi thurfa ad thjappa myndbandid
% handvirkt utan matlab, t.d med ffmpeg.
fig=figure;
%% Fastar
%lotur = 5;          %Fjoldi lota til ad reikna
%n = 25;             %Fjoldi mynda i hverri lotu               
theta0 = 2;         %theta(t0)
theta1 = 0;         %theta'(t0)
%omega = 1;          %Hornhradi
%t0 = 0;
%res = 6;
%% Jofnurnar

simple = adams_pc5(RHS,t0,x0,2*pi*lotur,res*lotur*n);
theta = @(t)  simple(1, res*floor(t*n/(2*pi)) + 1);
phi = @(t)  simple(2, res*floor(t*n/(2*pi)) + 1);
ptheta = @(t) simple(3, res*floor(t*n/(2*pi)) + 1);
pphi = @(t) simple(4, res*floor(t*n/(2*pi)) + 1);
%%
% Thar sem vid hreinsum myndina i hverju skrefi ta thurfum vid ad geyma
% fasahnitin i fylki
%fasahnit = [theta(0);dtheta(0)];
fasahnit = [theta(0);phi(0)];
x = @(t) sin(theta(t))*cos(phi(t));
y = @(t) sin(theta(t))*sin(phi(t));
z = @(t) -cos(theta(t)); %theta er midad vid ofugan z-as en venjulega
for t = 0:2*pi/n:2*pi*lotur
    %% Fasaritid
    %subplot(2,1,1) %Skipar matlab ad nota seinni hlutan af myndflotinum
    
    fasahnit = [fasahnit(1,:) x(t); fasahnit(2,:) y(t)]; %Baetir nyju fasahnitunum vid thau gomlu.
    
    %plot(x(t),y(t),'ob', 'MarkerSize', 6) %Punkturinn i
                                                   %fasaritinu
     
    %hold on % Thurfum ad setja "hold on" her svo vid yfirskrifum ekki linuna i fasaritnu bara med punktinum
    
    %plot(fasahnit(1,:),fasahnit(2,:),'b') % Linan i fasaritinu
    %hold on 
    %axis([-1.2,1.2,-1.2,1.2])
    %axis square

    %hold off 
    %% Pendullinn
    %Skiptir myndaflotinum i 2x1 fylki og segir matlab ad nota fyrsta stakid
    % Teikniskipun fyrir pendulinn: teiknum linu fra [0,0] (festipunktur) 
    % i [sin(theta(t)),-cos(theta(t))] sem er stadsetning lodsins
    % '-o' segir ad vid aetlum ad teikna linu med hringlaga endapunkta
    % 'MarkerSize' setur staerd endapunktanna
    % 'MarkerFaceColor' akvardar lit endapunktana
    
    
    %subplot(2,1,2)
    plot3([0,x(t)],[0,y(t)],[0,z(t)],'-o','MarkerSize',8,'MarkerFaceColor','b') 
    hold on
    plot3(fasahnit(1,:),fasahnit(2,:),zeros(1,length(fasahnit(2,:)))-1,'r', ...
          'MarkerSize',8,'MarkerFaceColor','r')
   % hold off
    grid %minor
    axis([-1.2,1.2,-1.2,1.2,-1.2,1.2]) %Festir asana
    axis square %Thvingar matlab til ad hafa x og y asinn jafn
    hold off
    %% Hreyfimynd
    F = getframe(fig); %Naer i nyjasta ramman
    aviobj = addframe(aviobj,F); % Og skeytir thvi vid restina
end
%% Fragangur
close(fig); %Lokar myndinni til ad ekki se haegt ad yfirskrifa hana
aviobj = close(aviobj); %Lokar og byr til myndbandid
