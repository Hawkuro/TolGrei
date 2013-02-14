function y =  func2(alphas, qs, eps, x)
  y= 0;
  for i= 1:length(alphas)
    y = y+ alphas(i)* exp(-(dot((x-qs(i,:)), (x-qs(i,:))))/eps);
  end
end


 
