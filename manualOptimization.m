function optimManualParam=manualOptimization(A,manualParam,selectedModel,modelType)
 if(selectedModel==1)
 [x,y,x_plot,iter]=defOptimConstUni(A);
 for i=1:3
   optimMethod=i;
   [f,f_plot,f_error,manualParam]=prepareUniModel(x,y,x_plot,selectedModel,optimMethod); %Choosing retention model...
   if(optimMethod==1)
    [y_optim, optimParameters, kvg1, iter1, corp1, covp1, covr1, stdresid1, Z1, r2] = leasqr(x, y, manualParam, f); %Applying leasqr () to desired function...
    y_no_optim_plot=f(x_plot, manualParam);
    y_optim_plot=f(x_plot,optimParameters);
   elseif(optimMethod>1)
     if(optimMethod==2)
      [optimParameters,fval]=fminsearch(f,manualParam);
     elseif(optimMethod==3)
      [optimParameters, y_min, conv, iters, nevs] = powell(f, manualParam);
     endif
   y_optim=f_error(optimParameters);
   y_no_optim_plot=f_plot(manualParam);
   y_optim_plot=f_plot(optimParameters);
   optimParameters=optimParameters';
  endif
   r2=[cov(y,y_optim)/(std(y)*std(y_optim))].^2;
   error_optim=sumsq(y-y_optim)/sumsq(y);
   retentionUniPlot(x,y,x_plot,y_optim_plot,y_no_optim_plot,1); %Plotting results...
   B(i,:)=[manualParam optimParameters' error_optim r2];
  endfor
  k=find(min(B(:,length(B)-1)));
  optimManualParam=B(k,:);
  elseif(modelType==2)
  [x,x1,x2,z,w,X,Y,iter] = defOptimConstBi(A); %Defining constants for optimization calculation and plotting...
  for i=1:3
    optimMethod=i;
    [f,f_plot,f_error,manualParam]=prepareBiModel(x,x1,x2,z,w,X,Y,selectedModel,optimMethod); %f_error was f_leasqr
  if(optimMethod==1)
  [z_optim, optimParameters, kvg1, iter1, corp1, covp1, covr1, stdresid1, Z1, r2] = leasqr (x, z, manualParam, f);
   z_no_optim=f_error(manualParam);
   z_optim=f_error(optimParameters);
   z_no_optim_plot=f_plot(manualParam);
   z_optim_plot=f_plot(optimParameters);
  elseif(optimMethod>1)
    if(optimMethod==2)
      [optimParameters,fval]=fminsearch(f,manualParam);%Nelder-Mead optimization
    elseif(optimMethod==3)
      [optimParameters,fval]=powell(f,manualParam);%Powell method
    endif
    z_no_optim=f_error(manualParam);
    z_optim=f_error(optimParameters);
    z_no_optim_plot=f_plot(manualParam);
    z_optim_plot=f_plot(optimParameters);
    endif
    %Optimization relative error...
    r2=[cov(z,z_optim)/(std(z)*std(z_optim))].^2
    error_no_optim=sumsq(z-z_no_optim)/sumsq(z);
    error_optim=sumsq(z-z_optim)/sumsq(z);
    retentionBiPlot(X,Y,z_no_optim_plot,z_optim_plot,1);
    if(i==1)
    B(i,:)=[manualParam optimParameters' error_optim r2];
    else
    B(i,:)=[manualParam optimParameters error_optim r2];
    endif
  endfor
  optim=find(min(B(:,length(B)-1)));
  optimManualParam=B(optim,:)';
 endif
end
