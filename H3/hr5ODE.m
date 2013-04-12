function y = hr5ODE (t,x)
sigma=10;
beta=8/3;
rho=28;
y(1) = sigma*(x(1) - x(2));
y(2) = x(1)*(rho - x(3)) - x(2);
y(3) = x(1)*x(2) - beta * x(3);