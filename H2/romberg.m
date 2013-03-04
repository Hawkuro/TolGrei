%
% Matlab-forrit sem reiknar �t n�lgun � heildi f yfir bili� [a,b] 
% me� Romberg-�tgiskun �t fr� trapisureglu
% 
% Falli� f er gefi� � m-skr�.  
% Inn fara:  f - gefi� fall sem � a� heilda
%            a og b - efra og ne�ra mark � heildinu
%            imax - h�marksfj�ldi l�na � �tgiskunart�flunni
%            epsilon - krafa um m�rk � skekkju
% �t koma:   I - n�lgun � heildinu 
%            mat - eftir�mat � skekkju
%            R -  �tgiskunartaflan 

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
