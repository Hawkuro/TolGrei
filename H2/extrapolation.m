%
% Matlab-forrit sem reiknar ut nalgun a hverju thvi sem R.m skilgreinir
% með utgiskun
%
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
D=cell(imax,imax);
D{1,1}=R(f,a,h);
i=2;
h=h/2;
mat1=2*epsilon;
while i<=imax & abs(mat1)>epsilon
    D{i,1}=R(f,a,h);
    for j=2:i
        mat2=(1/(4^(j-1)-1))*(D{i,j-1}-D{i-1,j-1});
        D{i,j}=D{i,j-1}+mat2;
    end
    mat1=norm(D{i,i}-D{i-1,i-1});
    X=D{i,i};
    i=i+1;
    h=h/2;
end
mat2=norm(mat2);
end
