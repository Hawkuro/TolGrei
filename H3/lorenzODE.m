function y = lorenzODE (t,x,cond)
    %fall sem er jofnuhneppi lorenz kerfis
    %t er breytan 
    %x er vigur með upphafs og endaskilyrðum
    %cond er vigur sem inniheldur stika lorenz kerfisins
    sigma = cond(1);
    r = cond(2);
    b = cond(3);
    y(1) = sigma* (x(2) - x(1));
    y(2) = x(1) * (r - x(3)) - x(2);
    y(3) = x(1)* x(2) - b*(x(3));
