function y = Fgeneral(f,h1,x) 
   y = [ (f(x(1) + h1, x(2)) - f(x(1)-h1,x(2)))/(2*h1); (f(x(1), x(2) + h1) - f(x(1),x(2)-h1))/(2*h1)];
end
