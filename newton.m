% Matlab-forrit fyrir aðferð Newtons.
%
% Inntak:  F    fallbreyta (e. function handle)
%          dF   Jacobi fylki F .
%          x0   upphafságiskun á núllstöð 
%          nmax hámarksfjöldi ítrekana
%          epsilon    skekkjumörk 
%          delta     þolmörk á fallgildum
%
% Úttak:   x    nálgun á núllstöð
function x=newton(F,dF,epsilon,delta,nmax,x0)
% Upphafsstilling:
n=0;
x=x0; 
%fprintf('%1d  %21.15e\n',n,x')
y=F(x);
dy=dF(x) ;
h=-dy\y; 
x=x+h;
n=1; 
e0=norm(h);
e=2*epsilon;
while e>epsilon & norm(y)>delta & n<nmax
   y=F(x); dy=dF(x);
  h=-dy\y; 
  e=norm(h);
%  fprintf('%1d  %21.15e %9.3e %9.3e\n',n,x',e,e/e0^2)
  x=x+h;
  n=n+1;
  e0=e;
end
%fprintf('%1d  %21.15e %9.3e %9.3e\n',n,x',e,e/e0^2)
