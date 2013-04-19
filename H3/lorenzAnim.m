function y = lorenzAnim(nafn,viewinit,viewspeed,lotur,n,res,cond,points,markercolors,plotcolors)
%% lorenzAnim.m
% Skipanaskra sem byr til hreyfimynd af lorenz attractor,
% tekur inn hve lengi a ad keyra, hve margir rammar a sekundu,
% hversu margfalt meira er renderad af gildum, upphafsgildi
% einda a formi lista [[sigma1;r1;b1], [sigma2;r2;b2]] etc
% upphafs stadsetningar þeirra a formi
% [[x0,y0,z0];[x0_2,y0_2,z0_2];...] etc sama lengd og
% upphafsskilirdin
% og svo tvo vigra markercolors og plotcolors sem segja til um
% litina a eindunm og ferlunum sem thaer skilja eftir sig.

aviobj = avifile(nafn,'compression','None','fps',16); %#ok<REMFF1>
% Segir til um nafn myndbandsins, thjoppun og fjolda ramma a sek.
% Windows notendur aettu ad breyta 'None' i 'Indeo5' eda i einhvern annan
% compression moguleika.
% Mac, Linux, BSD og onnur styrikerfi thurfa ad thjappa myndbandid
% handvirkt utan matlab, t.d med ffmpeg.
fig=figure;

s = size(cond);
fjoldi = s(2);
%Byr til follin og reiknar ut nalgunina a theim
for i = 1:fjoldi
    lorenzFunc = @(t,x) lorenzODE(t,x,cond(:,i));
    Sol(i, : , :) = adams_pc5(lorenzFunc,0,points(i,:),lotur,res*lotur*n);
end

axisCoords =  [min(min(Sol(:,1,:)))-3, max(max(Sol(:,1,:)))+3, min(min(Sol(:,2,:)))-3, max(max(Sol(:,2,:)))+3, min(min(Sol(:,3,:)))-3, max(max(Sol(:,3,:)))+3];
    


whitebg('black')
for t = 0:1/n:lotur
    axis(axisCoords)
    curr = res*floor(t*n)+1;
    % Teiknar inn eindirnar
    for i = 1:fjoldi
        Solv = Sol(i,:,1:curr);
        plot3(Solv(1,1,curr),Solv(1,2,curr),Solv(1,3,curr), markercolors(i), 'MarkerSize', 6) 
        hold on
        x = Solv(1,1,:);
        y = Solv(1,2,:);
        z = Solv(1,3,:);
        plot3(x(:),y(:),z(:),plotcolors(i)) 
        hold on
        axis(axisCoords)
    end
    view(viewinit(1)+uint32(viewspeed(1)*t),viewinit(2)+uint32(viewspeed(2)*t))
    grid %minor
    hold off
    %% Hreyfimynd
    F = getframe(fig); %Naer i nyjasta ramman
    aviobj = addframe(aviobj,F); % Og skeytir thvi vid restina
end
%% Fragangur
close(fig); %Lokar myndinni til ad ekki se haegt ad yfirskrifa hana
aviobj = close(aviobj); %Lokar og byr til myndbandid
