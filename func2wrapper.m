function k = func2wrapper(inx,iny)
  eps = 0.04;
  a = [1,-1,1,-1];
  q = [0.5 0.5; 0.5 -0.5; -0.5 -0.5; -0.5 0.5];
  x = [inx,iny];
  k = func2(a,q,eps,x);
end
