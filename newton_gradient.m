%Prototypa, ekki klarad! (Keyrir ekki)
function x = newton_gradient(f,epsilon, delta, nmax, x0, P);
   %Skgr. follin sem vid notum
   h1 = 0.01 %Bara byrjun, tharf ad finna ut hvernig madur finnur a,b og c,d i forritinu.
   F = @(x) [ (f(x(1) + h1, x(2)) - f(x(1)-h1,x(2)))/(2*h1), (f(x(1), x(2) + h1) - f(x(1),x(2)-h1))/(2*h1)];
   A = @(x) (f(x(1) + h1, x(2)) + f(x(1)-h1,x(2)) - 2*f(x(1),x(2)))/(h1*h1);
   B = @(x) ( f(x(1) + h1, x(2)+h1) - f(x(1) + h1, x(2)-h1) - f(x(1) - h1, x(2)+h1) + f(x(1) - h1, x(2) -h1))/(4*h1*h1)
   C = @(x) (f(x(1) , x(2)+ h1) + f(x(1),x(2)-h1) - 2*f(x(1),x(2)))/(h1*h1);
   dF = @(x) [ A(x) B(x); B(x) C(x)]
     
    % Upphafsstilling:
    n=0;
    x=x0; 
    %fprintf('%1d  %21.15e\n',n,x')
    y=F(x)
    dy=dF(x) 
    h=-dy\y; 
    x=x+h 
    n=1; 
    e0=norm(h);
    e=2*epsilon;
    while e>epsilon & norm(y)>delta & n<nmax
        y=F(x); dy=dF(x);
        h=-dy\y; 
        e=norm(h);
        %  fprintf('%1d  %21.15e %9.3e %9.3e\n',n,x',e,e/e0^2)
        x=x+h  
        n=n+1  
        e0=e;
    end
end


