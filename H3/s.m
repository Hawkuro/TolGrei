function y = s(t)%athugum að þetta fall á að taka lággildi í neðstu stöðu og hágildi í efstu
    l = 1;
    a = 0.2;
    omega = 6;%þessi breytha verður að vera háð t þannig að  
    phi = pi/2;
    y = l+a*cos(omega*t+phi);
end
