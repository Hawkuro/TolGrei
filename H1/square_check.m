function flag = square_check(x,P)

v = zeros(2,4);
for i = 1:4;
    v(1:2,i) = P(1:2,i+1) - P(1:2,i);
end

n = zeros(2,4);

for i = 1:4
    n(1,i)=-v(2,i);
    n(2,i)=v(1,i);
end

flag = 1;

for i = 1:4;
    if n(1:2,i)'*(x-P(1:2,i)) > 0;
        flag = 0;
        break;
    end
end
