function [optimParameters,r2,error_no_optim,error_optim]=bivariantRetOptim(A,selectedModel,optimMethod)
%This function uses Levenberg Marquadt method to optimize parameters of
%diferent retention mathematical models. In this case, methods are bivariant, i.e, two
%variables are needed for retention estimation: these variables are a combination of surfactant and additives, depending on the case.
  [x,x1,x2,z,w,X,Y] = defOptimConstBi(A); %Defining constants for optimization calculation and plotting...
  [f,f_plot,f_error,estimParam]=prepareBiModel(x,x1,x2,z,w,X,Y,selectedModel,optimMethod); %f_error was f_leasqr
  %Checking previous conditions for leasqr() to work properly...
  global verbose; verbose = false;
  switch(optimMethod)
    case 1 [y_optim, optimParameters, kvg1, iter1, corp1, covp1, covr1, stdresid1, Z1, r2] = leasqr (x, z, estimParam, f);
    case 2 [optimParameters,fval]=fminsearch(f,estimParam);
    case 3 [optimParameters,fval]=powell(f,estimParam);
   endswitch
  z_no_optim=f_error(estimParam);
  z_optim=f_error(optimParameters);
  z_no_optim_plot=f_plot(estimParam);
  z_optim_plot=f_plot(optimParameters);
  retentionBiPlot(X,Y,z_no_optim_plot,z_optim_plot);
  %Optimization relative error...
  r2=[cov(z,z_optim)/(std(z)*std(z_optim))].^2
  error_no_optim=sumsq(z-z_no_optim)/sumsq(z);
  error_optim=sumsq(z-z_optim)/sumsq(z);
endfunction
