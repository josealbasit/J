function bestParam=manualOptimization(A,manualParam,selectedModel,modelType)
 l=2*length(manualParam)+2;
 C=zeros(3,l);
 if(modelType==1)
 [x,y,x_plot,iter,iterRandom]=defOptimConstUni(A);
 for j=1:3
   optimMethod=j;
   [f_min,f,f_plot,empiricalParam]=prepareUniModel(x,y,x_plot,selectedModel,optimMethod); %Choosing retention model...
   [optimParam r2 errorVector errorOptim]=optimizationProcess(x,y,f_min,f,manualParam,optimMethod)
   retentionUniPlot(x,y,x_plot,f,f_plot,manualParam,optimParam,0); %Plotting results...
   hold on
   errorMatrix(j,:)=errorVector;
   if (j==1)
   optimParam=optimParam';
   endif
   C(j,:)=[manualParam optimParam errorOptim r2]; %Storing optimized values
   pause(.5);
 endfor
   posOptimError=find(C(:,l-1)==min(C(:,l-1)));
   bestParam=C(posOptimError,:)'
   comparation(x,y,f,C,errorMatrix);
   plotErrorMatrix(errorMatrix,x,y);
 elseif(modelType==2)
   [x,x1,x2,z,w,X,Y,iterRandom] = defOptimConstBi(A); %Defining constants for optimization calculation and plotting...
   for j=1:3
    optimMethod=j;
    [f_min,f_plot,f,empiricalParam]=prepareBiModel(x,x1,x2,z,w,X,Y,selectedModel,optimMethod);
    [optimParam r2 errorVector errorOptim]=optimizationProcess(x,z,f_min,f,manualParam,optimMethod);
    retentionBiPlot(X,Y,f_plot,manualParam,optimParam,0); %Plotting results...
    hold on
    errorMatrix(j,:)=errorVector;
    if (j>1)
      optimParam=optimParam';
    endif
    optimParam
    C(j,:)=[manualParam optimParam' errorOptim r2]; %Storing optimized values
    endfor
   posOptimError=find(C(:,l-1)==min(C(:,l-1)));
   bestParam=C(posOptimError,:)'
   comparation(x,z,f,C,errorMatrix);
 endif
end
