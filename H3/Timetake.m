tic
adams_pc5('Test',0,0,5,100);
at=toc
tic
rkf45('Test',0,0,5,[0.0001,1,1]);
rkf45t=toc
tic
rkv56('Test',0,0,5,[0.0001,1,1]);
rkv56t=toc
%athugum að þessum lið er ekki lokið sjá verklýsingu