function [r2 errorVector error_optim]=optimStatistics(y,y_optim,p)
  n=length(y);
  r2=[cov(y,y_optim)/(std(y)*std(y_optim))].^2;
  errorVector=(y-y_optim)./y;
  error_mean=(y_optim-mean(y))/sum(abs(y_optim))
  error_optim=sum(abs(y-y_optim))/sum(abs(y));
  std_prediction=sumsq(y-y_optim)/(n-p)

end

