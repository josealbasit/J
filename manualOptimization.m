function optimManualParam=manualOptimization(A,optimMethod,manualParam,selectedModel)
 [x,y,x_plot,iter]=defOptimConstUni(A);
 for i=1:3
   optimMethod=i
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
   retentionUniPlot(x,y,x_plot,y_optim_plot,y_no_optim_plot); %Plotting results...
   B(i,:)=[manualParam optimParameters' error_optim r2];
 endfor
 k=find(min(B(:,length(B)-1)));
 optimManualParam=B(k,:);
end
