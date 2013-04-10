adamstimes=[];
rkf45times=[];
rkv56times=[];
numtests=100
for i=1:numtests
    tic
    adams_pc5('Test',0,0,5,100);
    adamstimes(i)=toc;
    tic
    rkf45('Test',0,0,5,[0.0001,1,1]);
    rkf45times(i)=toc;
    tic
    rkv56('Test',0,0,5,[0.0001,1,1]);
    rkv56times(i)=toc;
end
adamsmeantime=sum(adamstimes)/numtests
rkf45meantime=sum(rkf45times)/numtests
rkv56meantime=sum(rkv56times)/numtests
