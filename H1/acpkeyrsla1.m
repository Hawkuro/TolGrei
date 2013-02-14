f = @(x,y) func2wrapper(x,y);
automaticCriticalPointSearch(f,[-1,1,-1,1],0.001,0.001,100,11)