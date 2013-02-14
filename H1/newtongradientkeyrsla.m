P = [ -1,-1,1,1,-1;-1,1,1,-1,-1];
f = @(x,y) x^2 + y^2;
newton_gradient(f,0.001,0.001,100,[0.5;0.5],P)
f = @(x,y) x*y;
newton_gradient(f,0.001,0.001,100,[0.5;0.5],P)
f = @(x,y) sin(x) + cos(y);
newton_gradient(f,0.001,0.001,100,[-1.5;0.0],2*P)

