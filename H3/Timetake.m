adamstimes=[];
rkf45times=[];
rkv56times=[];
numtests=100
for i=1:numtests
    tic
    adams_pc5('Test',0,0,5,100);
    adamstimes(i)=toc;
    tic
<<<<<<< HEAD
    rkf45('Test',0,0,5,[0.0001,1,0.0001]);
    rkf45times(i)=toc;
    tic
    rkv56('Test',0,0,5,[0.0001,1,0.0001]);
=======
    rkf45('Test',0,0,5,[0.00001,1,0.00001]);
    rkf45times(i)=toc;
    tic
    rkv56('Test',0,0,5,[0.00001,1,0.00001]);
>>>>>>> b19e53d15a61018ba9c019a218de596e80f3c67e
    rkv56times(i)=toc;
end
adamsmeantime=sum(adamstimes)/numtests
rkf45meantime=sum(rkf45times)/numtests
rkv56meantime=sum(rkv56times)/numtests
