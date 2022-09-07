function [f,f_plot,f_error,estimParam]=prepareUniModel(x,y,x_plot,selectedModel,optimMethod)
   f_plot=0;f_error=0;
   %Choosing retention model...
   switch (selectedModel)
     case 1 %Equation 1
       if (optimMethod==1)
         f=@(x,p) p(1).*exp(-x.*p(2));
       else
         f_error=@(p)p(1).*exp(-x.*p(2));
         f_plot=@(p)p(1).*exp(-x_plot.*p(2));
         f=@(p)sum((y-p(1).*exp(-x.*p(2))).^2);
       endif
       coef=flip(polyfit(x,log(y),1));
       estimParam(1)=exp(coef(1)); estimParam(2)=-coef(2);
     case 2 %Equation 2
      if (optimMethod==1)
        f=@(x,p)p(1).*exp(-x.*p(2)+p(3).*x.^2);
      else
        f_error=@(p) p(1).*exp(-x.*p(2)+p(3).*(x.^2));
        f_plot=@(p) p(1).*exp(-x_plot.*p(2)+p(3).*(x_plot.^2));
        f=@(p)sum([y-p(1).*exp(-x.*p(2)+p(3).*(x.^2))].^2);
      endif
      coef=flip(polyfit(x,log(y),2));
      estimParam(1)=exp(coef(1)); estimParam(2)=-coef(2); estimParam(3)=coef(3);
     case 3 %Equation 3
      if (optimMethod==1)
        f=@(x,p) p(1).*exp(-p(2).*(x./(1+p(3).*x)));
      else
        f_error=@(p) p(1).*exp(-p(2).*(x./(1+p(3).*x)));
        f_plot=@(p) p(1).*exp(-p(2).*(x_plot./(1+p(3).*x_plot)));
        f=@(p)sum([y-p(1).*exp(-p(2).*(x./(1+p(3).*x)))].^2);
      endif
      coef=flip(polyfit(x,log(y),2));
      estimParam(1)=exp(coef(1)); estimParam(2)=-coef(2); estimParam(3)=-coef(3)/coef(2);
     case 4 %Equation 4
      if (optimMethod==1)
        f=@(x,p) [p(1).*(1+p(3).*x).^2].*exp(-(p(2).*(x./(1+p(3).*x))));
      else
        f_error=@(p) [p(1).*(1+p(3).*x).^2].*exp(-(p(2).*(x./(1+p(3).*x))));
        f_plot=@(p) [p(1).*(1+p(3).*x_plot).^2].*exp(-(p(2).*(x_plot./(1+p(3).*x_plot))));
        f=@(p)sum([y-[p(1).*(1+p(3).*x).^2].*exp(-(p(2).*(x./(1+p(3).*x))))].^2);
      endif
      coef=flip(polyfit(x,log(y),2));
      estimParam(1)=exp(coef(1)); estimParam(2)=-coef(2); estimParam(3)=-coef(3)/coef(2);
     case 5 %Equation 5
      if (optimMethod==1)
        f=@(x,p) (p(1).*x).^(-p(2));
      else
        f_error=@(p) (p(1).*x).^(-p(2));
        f_plot=@(p) (p(1).*x_plot).^(-p(2));
        f=@(p) sum([y-(p(1).*x).^(-p(2))].^2);
      endif
      coef=polyfit(x,(1./y),1);
      estimParam(1)=coef(1); estimParam(2)=1;
     case 6 %Equation 6
      if (optimMethod==1)
       f=@(x,p) (p(1)+p(2).*x).^(-p(3));
      else
       f_error=@(p) (p(1)+p(2).*x).^(-p(3));
       f_plot=@(p) (p(1)+p(2).*x_plot).^(-p(3));
       f=@(p) sum([y-(p(1)+p(2).*x).^(-p(3))].^2);
      endif
      coef=flip(polyfit(x,(1./y),1))
      estimParam(1:2)=coef; estimParam(3)=1;
     case 7 %Equation 7
      if (optimMethod==1)
        f=@(x,p) p(1)./[(1+(p(3)-1).*p(2).*x.*exp((p(3)-1).*log(p(1)))).^(1./(p(3)-1))];
      else
        f_error=@(p) p(1)./[(1+(p(3)-1)*p(2)*exp([p(3)-1]*log(p(1))).*x).^(1/(p(3)-1))];
        f_plot=@(p) p(1)./(1+(p(3)-1).*p(2).*x_plot.*p(1).*exp([p(3)-1].*log(p(1)))).^(1/(p(3)-1));
        f=@(p)sumsq(y-p(1)./(1+(p(3)-1).*p(2).*x.*p(1).*exp([p(3)-1].*log(p(1)))).^(1./(p(3)-1)));
      endif
      coef=polyfit(x,log(y),1);
      estimParam(1)=exp(coef(1)); estimParam(2)=-coef(2);estimParam(3)=1.1;
     case 8 %Equation 8
      if (optimMethod==1)
      f=@(x,p) p(1)./(1+p(2).*x);
      else
      f_error=@(p)[p(1)]./(1+p(2).*x);
      f_plot=@(p)[p(1)]./(1+p(2).*x_plot);
      f=@(p)sumsq(y-p(1)./(1+p(2).*x));
      endif
      coef=flip(polyfit(x,1./y,1));
      estimParam(1)=1/coef(1);estimParam(2)=coef(2)*estimParam(1);
     otherwise
      msgbox("An error ocurred in the selection of the model.");
    endswitch
  close;
  end
