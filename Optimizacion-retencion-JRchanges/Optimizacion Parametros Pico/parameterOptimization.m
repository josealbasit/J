 function [p1,r21,iter1,pearson_no_optim,pearson_optim,error_optim]=parameterOptimization(B,initParam)
%This function uses Levenberg-Marquadt Method or Nelder Mead method to optimize peak-related parameters [H_0, t_R A B]
%The optimized function is the Parabolic Variance Gaussian with the previous approximation of the parameters.
%%For now, B is the matrix representing the peak... initParam are the intial estimation for the parameters [H_0, t_R A B]
   packages(); %Using Optim package functions...
   t=B(:,1);
   y=B(:,2);
   s_0=.86839*(initParam(3).*initParam(4))./[sqrt(1+.24.^2).*(initParam(3)+initParam(4))]); %Initial value for auxiliar parameter in the model...
   initParam=[initParam s_0];
   iter1=0;
%Data bounds...Needed to avoid initial and final data to have a disproportionate impact in the optimization.
%Thus, we start at 10% height...
   m=find(y==max(y));
   percent_10=.001*initParam(1);
   y_izq=y(1:m);
   y_der=y(m+1:end);
   p_izq=closestValue(y_izq,percent_10);
   p_der=closestValue(y_der,percent_10);
   I=[p_izq m+p_der];
   t_modified=B(I(1):I(2),1);
   y_modified=B(I(1):I(2),2);
%Function Definition
   global verbose; verbose = false;
   X=menu("Choose the optimization method:","Levenberg-Marquadt","Nelder-Mead");
   switch(X)
     case 1 %Raw function (without minimizing squares) is needed to use LM method.
      f= @(t,p) p(1).*exp ((-.5.*(t-p(2)).^ 2 )./ ...
      ( p(5).^2  +  p(5).^2.* [(p(4)-p(3))./(p(4).* p(3))].*(t-p(2))+[(t-p(2))].^2.*[0.217-p(5).^2./(p(3).*p(4))]));
      [f1, p1, kvg1, iter1, corp1, covp1, covr1, stdresid1, Z1, r21] = leasqr(t_modified, y_modified, initParam, f);
     case 2 %Least squares function is required in fminsearch...
      f= @(t,p) p(1).*exp ((-.5.*(t-p(2)).^ 2 )./ ...
      (p(5).^2  +  p(5).^2.* [(p(4)-p(3))./(p(4).* p(3))].*(t-p(2))+[(t-p(2))].^2.*[0.217-p(5).^2./(p(3).*p(4))]));
      fNelderMead=@(p)sumsq(y_modified-f(t_modified,p)); %We need to introduce the
      [p1,fval]=fminsearch(fNelderMead,initParam);
      f1=f(t_modified,p1);
   endswitch
   [f_no_optim]=comparationPlot(f,f1,t,y,t_modified,initParam);
%Coefficient of determination calculus...
   pearson_no_optim=(cov(y_modified,f_no_optim)/(std(y_modified)*std(f_no_optim)))^2;
   pearson_optim=(cov(y_modified,f1)/(std(y_modified)*std(f1)))^2;
   r21=pearson_optim^2;
   error_optim=sumsq(y_modified-f1)/sumsq(y_modified);
%Función con cuatro parámetros (H_0,t_R,A,B). Esta función es para predicción. Aún no se utiliza

  %h_antigua= @(t,p) p(1).*exp ((-.5.*(t-p(2)).^ 2 )./ ...
  %(        ([(p(3).*p(4)).^2]./[(1+.45.^2).*(p(3)+p(4)).^2]) ...
  %+         ([(p(3).*p(4)).^2]./[(1+.45.^2).*(p(3)+p(4)).^2]).* [(p(4)-p(3))./(p(4).* p(3))] .* ...
  %          [(t-p(2))./(1+.2.*abs(t-p(2))./(p(3)+p(4)))] ...
  %+         [(t-p(2))./(1+.2.*abs(t-p(2))./(p(3)+p(4)))].^2.*...
  %          [0.217-([(p(3).*p(4)).^2]./[(1+.45.^2).*(p(3)+p(4)).^2])./(p(3).*p(4))]  )  ) ;

%Función con cinco parámetros (H_0,t_R,A,B,p(5))

  %h= @(t,p) p(1).*exp ((-.5.*(t-p(2)).^ 2 )./ ...
  %(         ([.86839*(p(3).*p(4)).^2]./[(1+p(5).^2).*(p(3)+p(4)).^2]) ...
  %+         ([.86839*(p(3).*p(4)).^2]./[(1+p(5).^2).*(p(3)+p(4)).^2]).* [(p(4)-p(3))./(p(4).* p(3))] .* ...
  %          [(t-p(2))./(1+.2.*abs(t-p(2))./(p(3)+p(4)))] ...
  %+         [(t-p(2))./(1+.2.*abs(t-p(2))./(p(3)+p(4)))].^2.*...
  %          [0.217-([.86839*(p(3).*p(4)).^2]./[(1+p(5).^2).*(p(3)+p(4)).^2])./(p(3).*p(4))]  )  ) ;

%Función con cinco parámetros modificada para el uso en lsqcurvefit

  %h_lsq= @(p,t) p(1).*exp ((-.5.*(t-p(2)).^ 2 )./ ...
  % (         ([.86839*(p(3).*p(4)).^2]./[(1+p(5).^2).*(p(3)+p(4)).^2]) ...
  %+         ([.86839*(p(3).*p(4)).^2]./[(1+p(5).^2).*(p(3)+p(4)).^2]).* [(p(4)-p(3))./(p(4).* p(3))] .* ...
  %          [(t-p(2))./(1+.2.*abs(t-p(2))./(p(3)+p(4)))] ...
  %+         [(t-p(2))./(1+.2.*abs(t-p(2))./(p(3)+p(4)))].^2.*...
  %          [0.217-([.86839*(p(3).*p(4)).^2]./[(1+p(5).^2).*(p(3)+p(4)).^2])./(p(3).*p(4))]  )  ) ;


%Función con 5 parámetros ((H_0,t_R,A,B,s_0). Para el uso de esta, tenemos que acotar la parábola
% para que no corte los ejes. Es decir, elegiremos valores a partir del 1% de la altura

%[h1, p1h, kvg1h, iter1h, corp1h, covp1h, covr1h, stdresid1h, Z1h, r21h] = leasqr (x, y, initParam, h);
   %[f12, p12, kvg12, iter12, corp12, covp12, covr12, stdresid12, Z12, r212] = leasqr (x, y, initParam, h_antigua);
   %[f12, p12, kvg12, iter12, corp1, covp1, covr1, stdresid1, Z1, r21] = leasqr (x, y, initParam_5, f);
   %[c, resnorm, residual, flag, output, lambda, jacob] = lsqcurvefit (h_lsq,initParam, x, y,lb,ub,optimset);
   %y_lsq=h_lsq(c,x);


 end
