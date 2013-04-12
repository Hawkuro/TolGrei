function y = hr5b(RHS,max,n,x0,t0,res)
%% pendull.m
% Skipanaskra sem byr til hreyfimynd af einfoldum penduli, tekur
% inn ODE pendulsins sem RHS, hve margar lotur, hve margar myndir per lotu, upphafsgildin
% theta0,theta1, omega og t0, og hve margrfaltfleiri itranir af
% nalgun eru en rommum.
aviobj = avifile('lorenz.avi','compression','None','fps',16); %#ok<REMFF1>
% Segir til um nafn myndbandsins, thjoppun og fjolda ramma a sek.
% Windows notendur aettu ad breyta 'None' i 'Indeo5' eda i einhvern annan
% compression moguleika.
% Mac, Linux, BSD og onnur styrikerfi thurfa ad thjappa myndbandid
% handvirkt utan matlab, t.d med ffmpeg.
fig=figure;
%% Fastar
%lotur = 5;          %Fjoldi lota til ad reikna
%n = 25;             %Fjoldi mynda i hverri lotu     
%omega = 1;          %Hornhradi
%t0 = 0;
%res = 6;
%% Jofnurnar

simple = adams_pc5(RHS,t0,x0,max,res*max*n);
size(simple)
x = @(t)  simple(1, res*t*n + 1);
y = @(t)  simple(2, res*t*n + 1);
z = @(t)  simple(3, res*t*n + 1);
%%
% Thar sem vid hreinsum myndina i hverju skrefi ta thurfum vid ad geyma
% fasahnitin i fylki
%fasahnit = [theta(0);dtheta(0)];
hnit = [x(0);y(0);z(0)];
for t = 0:1/n:max
    %% Fasaritid
    %subplot(2,1,1) %Skipar matlab ad nota seinni hlutan af myndflotinum
    
    hnit = [hnit(1,:) x(t); hnit(2,:) y(t); hnit(3,:) z(t)]; %Baetir nyju fasahnitunum vid thau gomlu.
    
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
    %plot3([0,x(t)],[0,y(t)],[0,z(t)],'-o','MarkerSize',8,'MarkerFaceColor','b') 
    %hold on
    plot3(hnit(1,:),hnit(2,:),hnit(3,:),'r','MarkerSize',8,'MarkerFaceColor','r')
   % hold off
    grid %minor
    %axis([-10.2,10.2,-10.2,10.2,0,40.2]) %Festir asana
    %axis square %Thvingar matlab til ad hafa x og y asinn jafn
    %hold off
    %% Hreyfimynd
    F = getframe(fig); %Naer i nyjasta ramman
    aviobj = addframe(aviobj,F); % Og skeytir thvi vid restina
end
%% Fragangur
close(fig); %Lokar myndinni til ad ekki se haegt ad yfirskrifa hana
aviobj = close(aviobj); %Lokar og byr til myndbandid
