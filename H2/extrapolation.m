%
% Matlab-forrit sem reiknar ut nalgun a f'(a) med
% Richardson-utgiskun ut fra midsettri mismunaformulu
%
% R(h)=(f(a+h)-f(a-h))/(2h)
%
% Inn fara: fallid f, sem skilgreint er med fallbreytu
%           a - punkturinn,
%           h - upphafsgildi a skreflengd,
%           imax - hamarksfjoldi itrekana,
%           epsilon - nakvaemniskrafan.
% Ut koma:  X - aftasta gildid i Richardson utgiskunartoflunni.
%           mat1 - svartsyna eftiramatid a skekkju, D(i,i)-D(i-1,i-1).
%           mat2 - brjartsyna eftiramatid a skekkju, D(i,i)-D(i,i-1).
%
function [X,mat1,mat2]=extrapolation(f,a,h0,imax,epsilon)
h=h0;
D=zeros(imax,imax,length(a));
D(1,1,:)=R(f,a,h);
i=2;
h=h/2;
mat1=2*epsilon;
while i<=imax & abs(mat1)>epsilon
    D(i,1,:,:)=R(f,a,h);
    for j=2:i
        mat2=(1/(4^(j-1)-1))*(D(i,j-1,:,:)-D(i-1,j-1,:,:));
        D(i,j,:,:)=D(i,j-1,:)+mat2;
    end
    mat1=(sum((D(i,i,:,:)-D(i-1,i-1,:,:)).^(2)))^(1/2);
    X=D(i,i,:,:);
    i=i+1;
    h=h/2;
end
mat2=(sum(mat2.^2))^(1/2);
end
