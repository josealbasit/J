function finalParam=univariantRetOptim(A,selectedModel,optimMethod)
   %This function uses Levenberg-Marquadt optimization method to optimize retention
   % model parameters from experimental raw data.
   [x,y,x_plot,iter]=defOptimConstUni(A);
   [f,f_plot,f_error,estimParam]=prepareUniModel(x,y,x_plot,selectedModel,optimMethod); %Choosing retention model...
   initialParameters=generateInitialParameters(estimParam,iter);
   l=2*length(estimParam)+2;
   B=zeros(iter+1,l);%This matrix will store different initial and optim Parameters along with their associated optimization results: relative error and R^2.
   global verbose; verbose = false; %Check previous condition to use optim function...
   if(optimMethod==1)
      [y_optim, optimParameters, kvg1, iter1, corp1, covp1, covr1, stdresid1, Z1, r2] = leasqr(x, y, estimParam, f); %Applying leasqr () to desired function...
      y_no_optim_plot=f(x_plot, estimParam);
      y_optim_plot=f(x_plot,optimParameters);
      r2=[cov(y,y_optim)/(std(y)*std(y_optim))].^2;
      error_optim=sumsq(y-y_optim)/sumsq(y);
      retentionUniPlot(x,y,x_plot,y_optim_plot,y_no_optim_plot); %Plotting results...
      B(1,:)=[estimParam optimParameters' error_optim r2]; %Storing optimized values
      for i=2:iter+1
        [y_optim, optimParameters, kvg1, iter1, corp1, covp1, covr1, stdresid1, Z1, r2] = leasqr(x, y, initialParameters(:,i-1), f); %Applying leasqr () to desired function...
        %Comparing optim vs non-optim function...
        y_no_optim_plot=f(x_plot, initialParameters(:,i-1));
        y_optim_plot=f(x_plot,optimParameters);
        r2=[cov(y,y_optim)/(std(y)*std(y_optim))].^2;
        error_optim=sumsq(y-y_optim)/sumsq(y);
        retentionUniPlot(x,y,x_plot,y_optim_plot,y_no_optim_plot); %Plotting results...
        w=[initialParameters(:,i-1)' optimParameters' error_optim r2];
        B(i,:)=w;
        %estimParam change%
      endfor
    elseif (optimMethod > 1)
      if (optimMethod==2)
        [optimParameters,fval]=fminsearch(f,estimParam);
      elseif(optimMethod==3)
        [optimParameters, y_min, conv, iters, nevs] = powell(f, estimParam);
      endif
      y_optim=f_error(optimParameters);
      y_no_optim_plot=f_plot(estimParam);
      y_optim_plot=f_plot(optimParameters);
      r2=[cov(y,y_optim)/(std(y)*std(y_optim))].^2;
      error_optim=sumsq(y-y_optim)/sumsq(y);
      retentionUniPlot(x,y,x_plot,y_optim_plot,y_no_optim_plot); %Plotting results...
      B(1,:)=[estimParam optimParameters error_optim r2];
      for i=2:iter+1
      if (optimMethod==2)
        [optimParameters,fval]=fminsearch(f,initialParameters(:,i-1));
      elseif(optimMethod==3)
        [optimParameters, y_min, conv, iters, nevs] = powell(f, initialParameters(:,i-1))
      endif
      y_optim=f_error(optimParameters);
      y_no_optim_plot=f_plot(initialParameters(:,i-1));
      y_optim_plot=f_plot(optimParameters);
      r2=[cov(y,y_optim)/(std(y)*std(y_optim))].^2;
      error_optim=sumsq(y-y_optim)/sumsq(y);
      retentionUniPlot(x,y,x_plot,y_optim_plot,y_no_optim_plot); %Plotting results...
      w=[initialParameters(:,i-1)' optimParameters' error_optim r2];
      B(i,:)=w;
      endfor
    endif
    optim=find(min(B(:,l-1)));
    finalParam=B(optim,:)';
 end

