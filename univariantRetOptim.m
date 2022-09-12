function [bestParam,x,y]=univariantRetOptim(A,selectedModel,optimMethod,errorMatrix)
   [x,y,x_plot,iter,iterRandom]=defOptimConstUni(A);
   [f_min,f,empiricalParam]=prepareUniModel(x,y,x_plot,selectedModel,3); %Choosing retention model...
   l=2*length(empiricalParam)+2;
   B=zeros(iterRandom,l);%This matrix will store different initial and optim Parameters along with their associated optimization results: relative error and R^2.
   C=zeros(iterRandom,l);
   D=zeros(0,0);
   %For non lineal convertible equations.
   randomParameters=generateRandomParameters(empiricalParam,iterRandom);
   for i=1:iterRandom
    initParam=randomParameters(:,i)';
    [optimParam r2 errorVector errorOptim]=optimizationProcess(x,y,f_min,f,initParam,3);
    %retentionUniPlot(x,y,initParam,optimParam,1); %Plotting results...
    errorMatrix(i,:)=errorVector;
    B(i,:)=[initParam optimParam errorOptim r2]; %Storing optimized values
   endfor
   B;
   rndOptimError=find(B(:,l-1)==min(B(:,l-1)));
   t=(l-2)/2;
   estimParam=B(rndOptimError,t+1:2*t)';
   estimParameters=generateEstimParameters(estimParam,iterRandom)
   for j=1:3
    optimMethod=j;
    [f_min,f,empiricalParam]=prepareUniModel(x,y,x_plot,selectedModel,optimMethod); %Choosing retention model...
    for i=1:iterRandom
      initParam=estimParameters(:,i);
      [optimParam r2 errorVector errorOptim]=optimizationProcess(x,y,f_min,f,initParam,optimMethod)
      %retentionUniPlot(x,y,initParam,optimParam,1); %Plotting results...
      errorMatrix(i,:)=errorVector;
      C(i,:)=[initParam' optimParam' errorOptim r2]; %Storing optimized values
    endfor
    D=[D;C]
   endfor
   posOptimError=find(D(:,l-1)==min(D(:,l-1)));
   bestParam=D(posOptimError,:)'
   comparation(x,y,f,D,errorMatrix);

 end

