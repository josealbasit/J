function [optimParameters,r2,error_optim]=univariantRetOptim(A,selectedModel,optimMethod)
   %This function uses Levenberg-Marquadt optimization method to optimize retention
   % model parameters from experimental raw data.
   [x,y,x_plot]=defOptimConstUni(A);
   [f,f_plot,f_error,initParam]=prepareUniModel(x,y,x_plot,selectedModel,optimMethod); %Choosing retention model...
   global verbose; verbose = false; %Check previous condition to use optim function...
   switch(optimMethod)
    case 1 [y_optim, optimParameters, kvg1, iter1, corp1, covp1, covr1, stdresid1, Z1, r2] = leasqr(x, y, initParam, f); %Applying leasqr () to desired function...
            %Comparing optim vs non-optim function...
            y_no_optim_plot=f(x_plot, initParam);
            y_optim_plot=f(x_plot,optimParameters);
    case 2 [optimParameters,fval]=fminsearch(f,initParam);
    case 3 [optimParameters, y_min, conv, iters, nevs] = powell(f, initParam)
   endswitch
   if (optimMethod > 1) %If optimization method is either NM or Powell
   y_optim=f_error(optimParameters);
   y_no_optim_plot=f_plot(initParam);
   y_optim_plot=f_plot(optimParameters);
   end
   r2=[cov(y,y_optim)/(std(y)*std(y_optim))].^2;
   error_optim=sumsq(y-y_optim)/sumsq(y);
   retentionUniPlot(x,y,x_plot,y_optim_plot,y_no_optim_plot); %Plotting results...
 end

