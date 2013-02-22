    x=[0, 0.4, 0.7, 0.9, 1];
    y=[1.22 ; 0.53 ; 0.34 ; 0.72 ; 1.22];
    m = length(x);
    A=zeros(m,3);
    i=1
    for i=1:m
        A(i,:)=[1,x(i)*(1-x(i)),exp(x(i))];
        
    end  
    c = (A'*A)\(A'*y);


xax=linspace(0,1,1000);
for i=1:length(xax)
	yax(i)=(c(1)+c(2)*xax(i)*(1-xax(i))+c(3)*exp(xax(i)));
end
close all
hold on
plot(xax,yax)
plot(x,y,'+')
hold off
