%
% Matlab-forrit sem reiknar út nálgun á f'(a) með
% Richardson-útgiskun út frá miðsettri mismunaformúlu
%
% R(h)=(f(a+h)-f(a-h))/(2h)
%
% Inn fara: fallið f, sem skilgreint er með fallbreytu
%           a - punkturinn,
%           h - upphafsgildi á skreflengd,
%           imax - hámarksfjöldi ítrekana,
%           epsilon - nákvæmniskrafan.
% Út koma:  X - aftasta gildið í Richardson útgiskunartöflunni.
%           mat1 - svartsýna eftirámatið á skekkju, D(i,i)-D(i-1,i-1).
%           mat2 - brjartsýna eftirámatið á skekkju, D(i,i)-D(i,i-1).
%
function [X,mat1,mat2]=extrapolation(f,a,h0,imax,epsilon)
h=h0;
D(1,1)=R(f,a,h);
i=2;
h=h/2;
mat1=2*epsilon;
while i<=imax & abs(mat1)>epsilon
    D(i,1)=R(f,a,h);
    for j=2:i
        mat2=(1/(4^(j-1)-1))*(D(i,j-1)-D(i-1,j-1));
        D(i,j)=D(i,j-1)+mat2;
    end
    mat1=norm(D(i,i)-D(i-1,i-1));
    X=D(i,i);
    i=i+1;
    h=h/2;
end
mat2=norm(mat2);
end