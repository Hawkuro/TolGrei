function [wi, ti] = adams_pc4 ( RHS, t0, x0, tf, N )

%ADAMS_PC4  approximate the solution of the initial value problem
%
%                       x'(t) = RHS( t, x ),    x(t0) = x0
%
%           using the Adams fourth-order predictor / corrector scheme
%           - this routine will work for a system of first-order 
%           equations as well as for a single equation
%
%           the classical fourth-order Runge-Kutta method is used to 
%           initialize the predictor / corrector scheme
%
%
%     calling sequences:
%             [wi, ti] = adams_pc4 ( RHS, t0, x0, tf, N )
%             adams_pc4 ( RHS, t0, x0, tf, N )
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

for i = 1:3
    oldf(i,1:neqn) = feval ( RHS, t0, x0 );
    k1 = h * oldf(i,:);
	k2 = h * feval ( RHS, t0 + h/2, x0 + k1/2 );
	k3 = h * feval ( RHS, t0 + h/2, x0 + k2/2 );
	k4 = h * feval ( RHS, t0 + h, x0 + k3 );
    x0 = x0 + ( k1 + 2*k2 + 2*k3 + k4 ) / 6;
	t0 = t0 + h;

    wi(1:neqn,i+1) = x0';	
end;

%
%  continue time stepping with 4th order Adams Predictor / Corrector
%

for i = 4:N
    fnew = feval ( RHS, t0, x0 );
    xtilde = x0 + (h/24) * ( 55*fnew - 59*oldf(3,:) + 37*oldf(2,:) - 9*oldf(1,:) );
	fnew1 = feval ( RHS, t0+h, xtilde );
	x0 = x0 + (h/24) * ( 9*fnew1 + 19*fnew - 5*oldf(3,:) + oldf(2,:) );
	oldf(1,1:neqn) = oldf(2,1:neqn);
	oldf(2,1:neqn) = oldf(3,1:neqn);
	oldf(3,1:neqn) = fnew;
	t0 = t0 + h;

    wi(1:neqn,i+1) = x0';	
end;