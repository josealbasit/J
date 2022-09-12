function finalParam=bivariantRetOptim(A,selectedModel,optimMethod)
%This function uses Levenberg Marquadt method to optimize parameters of
%diferent retention mathematical models. In this case, methods are bivariant, i.e, two
%variables are needed for retention estimation: these variables are a combination of surfactant and additives, depending on the case.
  [x,x1,x2,z,w,X,Y,iter] = defOptimConstBi(A); %Defining constants for optimization calculation and plotting...
  [f,f_plot,f_error,estimParam]=prepareBiModel(x,x1,x2,z,w,X,Y,selectedModel,optimMethod); %f_error was f_leasqr
  initialParameters=generateInitialParameters(estimParam,iter);
  l=2*length(estimParam)+2;
  B=zeros(iter+1,l);%This matrix will store different initial and optim Parameters along with their associated optimization results: relative error and R^2.
  %Checking previous conditions for leasqr() to work properly...
  global verbose; verbose = false;
  if(optimMethod==1)
    [z_optim, optimParameters, kvg1, iter1, corp1, covp1, covr1, stdresid1, Z1, r2] = leasqr (x, z, estimParam, f);
    z_no_optim=f_error(estimParam);
    z_optim=f_error(optimParameters);
    z_no_optim_plot=f_plot(estimParam);
    z_optim_plot=f_plot(optimParameters);
    retentionBiPlot(X,Y,z_no_optim_plot,z_optim_plot,1);
    %Optimization relative error...
    r2=[cov(z,z_optim)/(std(z)*std(z_optim))].^2
    error_no_optim=sumsq(z-z_no_optim)/sumsq(z);
    error_optim=sumsq(z-z_optim)/sumsq(z);
    estimParam
    optimParameters
    B(1,:)=[estimParam optimParameters' error_optim r2];
  for i=2:iter+1
    [z_optim, optimParameters, kvg1, iter1, corp1, covp1, covr1, stdresid1, Z1, r2] = leasqr (x, z, initialParameters(:,i-1), f);
    z_no_optim=f_error(initialParameters(:,i-1));
    z_optim=f_error(optimParameters);
    z_no_optim_plot=f_plot(initialParameters(:,i-1));
    z_optim_plot=f_plot(optimParameters);
    retentionBiPlot(X,Y,z_no_optim_plot,z_optim_plot,1);
    %Optimization relative error...
    r2=[cov(z,z_optim)/(std(z)*std(z_optim))].^2
    error_no_optim=sumsq(z-z_no_optim)/sumsq(z);
    error_optim=sumsq(z-z_optim)/sumsq(z);
    B(i,:)=[initialParameters(:,i-1)' optimParameters' error_optim r2];
  endfor
  elseif(optimMethod > 1)
    if(optimMethod==2)
    [optimParameters,fval]=fminsearch(f,estimParam);%Nelder-Mead optimization
    elseif(optimMethod==3)
    [optimParameters,fval]=powell(f,estimParam);%Powell method
    endif
    z_no_optim=f_error(estimParam);
    z_optim=f_error(optimParameters);
    z_no_optim_plot=f_plot(estimParam);
    z_optim_plot=f_plot(optimParameters);
    retentionBiPlot(X,Y,z_no_optim_plot,z_optim_plot,1);
    %Optimization relative error...
    r2=[cov(z,z_optim)/(std(z)*std(z_optim))].^2
    error_no_optim=sumsq(z-z_no_optim)/sumsq(z);
    error_optim=sumsq(z-z_optim)/sumsq(z);
    optimParameters
    B(1,:)=[estimParam optimParameters error_optim r2];
    for i=2:iter+1
      if(optimMethod==2)
        [optimParameters,fval]=fminsearch(f,initialParameters(:,i-1));
      elseif(optimMethod==3)
        [optimParameters,fval]=powell(f,initialParameters(:,i-1));
      endif
      z_no_optim=f_error(initialParameters(:,i-1));
      z_optim=f_error(optimParameters);
      z_no_optim_plot=f_plot(initialParameters(:,i-1));
      z_optim_plot=f_plot(optimParameters);
      retentionBiPlot(X,Y,z_no_optim_plot,z_optim_plot,1);
      %Optimization relative error...
      r2=[cov(z,z_optim)/(std(z)*std(z_optim))].^2
      error_no_optim=sumsq(z-z_no_optim)/sumsq(z);
      error_optim=sumsq(z-z_optim)/sumsq(z);
      B(i,:)=[initialParameters(:,i-1)' optimParameters' error_optim r2];
  endfor
  endif
  optim=find(min(B(:,l-1)));
  finalParam=B(optim,:)';
endfunction
