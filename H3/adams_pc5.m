function [wi, ti] = adams_pc5 ( RHS, t0, x0, tf, N )

%ADAMS_PC5  approximate the solution of the initial value problem
%
%                       x'(t) = RHS( t, x ),    x(t0) = x0
%
%           using the Adams fifth-order predictor / corrector scheme
%           - this routine will work for a system of first-order 
%           equations as well as for a single equation
%
%           the classical fifth-order Runge-Kutta method is used to 
%           initialize the predictor / corrector scheme
%
%
%     calling sequences:
%             [wi, ti] = adams_pc5 ( RHS, t0, x0, tf, N )
%             adams_pc5 ( RHS, t0, x0, tf, N )
%
%     inputs:
%             RHS     string containing name of m-file defining the 
%                     right-hand side of the differential equation;  the
%                     m-file must take two inputs - first, the value of
%                     the independent variable; second, the value of the
%                     dependent variable
%             t0      initial value of the independent variable
%             x0      initial value of the dependent variable(s)
%                     if solving a system of equations, this should be a 
%                     row vector containing all initial values
%             tf      final value of the independent variable
%             N       number of uniformly sized time steps to be taken to
%                     advance the solution from t = t0 to t = tf
%
%     output:
%             wi      vector / matrix containing values of the approximate 
%                     solution to the differential equation
%             ti      vector containing the values of the independent 
%                     variable at which an approximate solution has been
%                     obtained
%

neqn = length ( x0 );
ti = linspace ( t0, tf, N+1 );
wi = [ zeros( neqn, N+1 ) ];
wi(1:neqn, 1) = x0';

h = ( tf - t0 ) / N;
oldf = zeros(3,neqn);

%
%  generate starting values using classical 4th order RK method
%  remember to save function values
%

for i = 1:4
    oldf(i,1:neqn) = feval ( RHS, t0, x0 );
    k1 = h * oldf(i,:);
	k2 = h * feval ( RHS, t0 + h/4, x0 + k1/4 );
	k3 = h * feval ( RHS, t0 + 3*h/8, x0 + k1*3/32 + k2*9/32 );
	k4 = h * feval ( RHS, t0 + 12/13*h, x0 + 1932/2197*k1 + 7200/2197*k2 + 7296/2197*k3 );
    k5 = h * feval ( RHS, t0 + h, x0 + 439/216*k1 - 8*k2 + 3680/513*k3 + 845/4104*k4);
    k6 = h * feval ( RHS, t0 + h/2, x0 - 8/27*k1 + 2*k2 - 3544/2565*k3 + 1859/4104*k4 - 11/40*k5);
    x0 = x0 + 16/135*k1 + 6656/12825*k3 + 28561/56430*k4 - 9/50*k5 + 2/55*k6;
	t0 = t0 + h;

    wi(1:neqn,i+1) = x0';	
end;

%
%  continue time stepping with 5th order Adams Predictor / Corrector
%

for i = 4:N
    fnew = feval ( RHS, t0, x0 );
    xtilde = x0 + h*( 1901/720*fnew - 1387/360*oldf(4,:) + 109/30*oldf(3,:) - 637/360*oldf(2,:) + 251/720*oldf(1,:));
	fnew1 = feval ( RHS, t0+h, xtilde );
    x0 = x0 + h/720*(251*fnew1 + 646*fnew - 264*oldf(4,:) + 106*oldf(3,:) - 19*oldf(2,:));
	oldf(1,1:neqn) = oldf(2,1:neqn);
	oldf(2,1:neqn) = oldf(3,1:neqn);
	oldf(3,1:neqn) = oldf(4,1:neqn);
    oldf(4,1:neqn) = fnew;
	t0 = t0 + h;

    wi(1:neqn,i+1) = x0';	
end;
