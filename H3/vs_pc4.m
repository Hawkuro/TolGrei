function [wi, ti, count] = vs_pc4 ( RHS, t0, x0, tf, parms )

%VS_PC4    approximate the solution of the initial value problem
%
%                       x'(t) = RHS( t, x ),    x(t0) = x0
%
%          using the variable step size Adams fourth-order predictor /
%          corrector scheme - this routine will work for a system of 
%          first-order equations as well as for a single equation
%
%     calling sequences:
%             [wi, ti] = vs_pc4 ( RHS, t0, x0, tf, parms )
%             vs_pc4 ( RHS, t0, x0, tf, parms )
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
%             parms   three component vector of paramter values
%                     parm(1)      minimum allowed step size
%                     parm(2)      maximum allowed step size
%                     parm(3)      absolute error tolerance
%
%     output:
%             wi      vector / matrix containing values of the approximate 
%                     solution to the differential equation
%             ti      vector containing the values of the independent 
%                     variable at which an approximate solution has been
%                     obtained
%             count   number of function evaluations used in advancing the
%                     solution from t = t0 to t = tf
%

neqn = length ( x0 );
hmin = parms(1);
hmax = parms(2);
TOL  = parms(3);

ti(1) = t0;
wi(1:neqn, 1) = x0';
count = 0;
h = hmax;

oldf = zeros(3,neqn);
done = 0;
last = 0;
flag = 1;
ts = 1;

while ( done == 0 )
%
%  generate starting values using classical 4th order RK method
%  remember to save function values
%

    if ( flag == 1 )
       for i = 1:3
           oldf(i,1:neqn) = feval ( RHS, t0, x0 );
           k1 = h * oldf(i,:);
	       k2 = h * feval ( RHS, t0 + h/2, x0 + k1/2 );
	       k3 = h * feval ( RHS, t0 + h/2, x0 + k2/2 );
  	       k4 = h * feval ( RHS, t0 + h, x0 + k3 );
           x0 = x0 + ( k1 + 2*k2 + 2*k3 + k4 ) / 6;
	       t0 = t0 + h;

           ti(ts+i) = t0;
           wi(1:neqn, ts+i) = x0';
       end;
       count = count + 12;
	   ts = ts + 3;
    end;

%
%  continue time stepping with 4th order Adams Predictor / Corrector
%

    fnew = feval ( RHS, t0, x0 );
    xtilde = x0 + (h/24) * ( 55*fnew - 59*oldf(3,:) + 37*oldf(2,:) - 9*oldf(1,:) );
	fnew1 = feval ( RHS, t0+h, xtilde );
	x0 = x0 + (h/24) * ( 9*fnew1 + 19*fnew - 5*oldf(3,:) + oldf(2,:) );
	
	R = max ( 19 * abs ( x0 - xtilde ) / ( 270 * h ) );
	q = ( TOL / (2*R) ) ^ (1/4);
	count = count + 2; 
	
	if ( R < TOL )
	   ts = ts + 1;
	   t0 = t0 + h;
	   ti(ts) = t0;
       wi(1:neqn, ts) = x0';
	   oldf(1,1:neqn) = oldf(2,1:neqn);
	   oldf(2,1:neqn) = oldf(3,1:neqn);
	   oldf(3,1:neqn) = fnew;
	   if ( last == 1 ) 
	      done = 1;
	   elseif ( R < 0.1 * TOL | ( t0 + h ) > tf )
	      if ( R < 0.1 * TOL ) h = min ( hmax, min ( q, 4.0 ) * h );  end;
		  if ( ( t0 + 4*h ) > tf ) h = ( tf - t0 ) / 4;  last = 1;  end;
	      flag = 1; 
	   else
	      flag = 0;
	   end;
	else
		h = max ( q, 0.1 ) * h;
        if ( h < hmin )
	       disp ( 'Solution requires step size smaller than minimum' );
	       return;
	    end;
		if ( flag == 1 )
		   ts = ts - 3;
		end;
		t0 = ti(ts);
		x0 = wi(1:neqn, ts)';
		flag = 1;
		if ( ( t0 + 4*h ) > tf ) 
		   h = ( tf - t0 ) / 4;  
		   last = 1; 
        else
		   last = 0;
		end;
	end;
end;

