%
% Matlab-forrit sem reiknar út nálgun á heildi f yfir bilið [a,b] 
% með Romberg-útgiskun út frá trapisureglu
% 
% Fallið f er gefið í m-skrá.  
% Inn fara:  f - gefið fall sem á að heilda
%            a og b - efra og neðra mark á heildinu
%            imax - hámarksfjöldi lína í útgiskunartöflunni
%            epsilon - krafa um mörk á skekkju
% Út koma:   I - nálgun á heildinu 
%            mat - eftirámat á skekkju
%            R -  útgiskunartaflan 

function [I,mat,R]=romberg(f,a,b,imax,epsilon)
h=b-a;
R(1,1)=h*(f(a)/2+f(b)/2);
i=2; h=h/2; mat=2*epsilon;
while i<=imax & abs(mat)>epsilon
  sum=0;
  for k=1:2^(i-2)
    sum=sum+f(a+(2*k-1)*h);
  end
  R(i,1)=R(i-1,1)/2+h*sum;
  for j=2:i
    mat=(1/(4^(j-1)-1))*(R(i,j-1)-R(i-1,j-1));
    R(i,j)=R(i,j-1)+mat;
  end
  I=R(i,i);
  i=i+1; h=h/2;
end
