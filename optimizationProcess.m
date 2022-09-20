function [optimParam r2 errorVector errorOptim]=optimizationProcess(x,y,f_min,f,initParam,optimMethod)
  if(optimMethod==1)%Levenberg-Marquadt Algorithm
      options=generateBounds(initParam)
      wt = ones(size(y));
      dp = [0.001; 0.001; 0.001]; % bidirectional numeric gradient stepsize
      [y_optim, optimParam, kvg1, iter1, corp1, covp1, covr1, stdresid1, Z1, r2] = leasqr(x, y, initParam, f_min,0.000001, 200, wt, dp, "dfdp", options); %Applying leasqr () to desired function...
  elseif (optimMethod > 1)
      if (optimMethod == 2) %NelderMeadAlgorithm
        [optimParam,fval]=fminsearch(f_min,initParam);
      elseif(optimMethod==3) %Powell algorithm
        [optimParam, fval, conv, iters, nevs] = powell(f_min,initParam);
      endif
      y_optim=f(optimParam);
  endif
      [r2 errorVector errorOptim]=optimStatistics(y,y_optim,length(initParam));
  end
