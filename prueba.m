function prueba(x,y,initParam)

  f_min=@(x,p) p(1).*exp(-p(2).*(x./(1+p(3).*x)));
  [A options]=generateBounds(initParam);
  options.bounds(1,:)=[66 100]
  wt = ones(size(y));
  dp = [0.001; 0.001; 0.001]; % bidirectional numeric gradient stepsize
  options
  [y_optim, optimParam, kvg1, iter1, corp1, covp1, covr1, stdresid1, Z1, r2] = leasqr(x, y, initParam, f_min, 0.000001, 200, wt, dp, "dfdp", options) %Applying leasqr () to desired function...

end








