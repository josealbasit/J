function [optimParam r2 errorVector errorOptim]=optimizationProcess(x,y,f_min,f,initParam,optimMethod)
  if(optimMethod==1)
      [y_optim, optimParam, kvg1, iter1, corp1, covp1, covr1, stdresid1, Z1, r2] = leasqr(x, y, initParam, f_min); %Applying leasqr () to desired function...
  elseif (optimMethod > 1)
      if (optimMethod == 2) %NelderMeadAlgorithm
        [optimParam,fval]=fminsearch(f_min,initParam);
      elseif(optimMethod==3) %Powell algorithm
        [optimParam, fval, conv, iters, nevs] = powell(f_min,initParam);
      endif
      y_optim=f(optimParam);
  endif
      [r2 errorVector errorOptim]=optimStatistics(y,y_optim)
  end
