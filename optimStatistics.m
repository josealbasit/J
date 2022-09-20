function [r2 errorVector error_optim]=optimStatistics(y,y_optim)

  r2=[cov(y,y_optim)/(std(y)*std(y_optim))].^2;
  errorVector=(y-y_optim)./y;
  error_optim=sumsq(y-y_optim)/sumsq(y);
%  std_prediction=sumsq(mean(y)-y_optim)/[length(y)-%numero de parametros];

end

