function y = dFgeneral(f,h1,x)
   A = @(x) (f(x(1) + h1, x(2)) + f(x(1)-h1,x(2)) - 2*f(x(1),x(2)))/(h1*h1);
   B = @(x) ( f(x(1) + h1, x(2)+h1) - f(x(1) + h1, x(2)-h1) - f(x(1) - h1, x(2)+h1) + f(x(1) - h1, x(2) -h1))/(4*h1*h1);
   C = @(x) (f(x(1) , x(2)+ h1) + f(x(1),x(2)-h1) - 2*f(x(1),x(2)))/(h1*h1);
   y = [ A(x) B(x); B(x) C(x)];
end
