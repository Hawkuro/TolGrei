
xg=[0	,0.4	,0.7	,0.9	,1];
yg=[1.22,0.53	,0.34	,0.72	,1.22];
fylki=eye(5,3);
i=1
while(i<=5)
	fylki(i,:)=[1,xg(i)*(1-xg(i)),exp(xg(i))];
	i++;
end

A=fylki
At=transpose(A)
A*At
