function x = newton_gradient(f,epsilon, delta, nmax, x0, P, axis)
   %Skgr. follin sem vid notum
   a =0; b = 1; c = 0; d = 1;
   if(nargin == 7)
       a = axis(1);
       b = axis(2);
       c = axis(3);
       d = axis(4);
   end
   
   h1 = 0.01 * min(b-a,d-c)
   F = @(x) Fgeneral(f,h1,x);
   dF = @(x) dFgeneral(f,h1,x); 
   % Upphafsstilling:
   n=0;
   x=x0; 
   %fprintf('%1d  %21.15e\n',n,x')
   y=F(x);
   dy=dF(x);
   h=-dy\y;
   x=x+h;
   n=1; 
   e0=norm(h);
   e=2*epsilon;
   while e>epsilon && norm(y)>delta && n<nmax && square_check(x,P)
       y=F(x); dy=dF(x);
       h=-dy\y; 
       e=norm(h);
       x=x+h;
       n=n+1;
       e0=e;
   end
end
