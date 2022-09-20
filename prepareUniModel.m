function [f_min,f,f_plot,estimParam]=prepareUniModel(x,y,x_plot,selectedModel,optimMethod)
   f_min=0;f=0;f_plot=0;
   %Choosing retention model...
   switch (selectedModel)
     case 1 %Equation 1
       f=@(p)p(1).*exp(-x.*p(2));
       f_plot=@(p)p(1).*exp(-x_plot.*p(2));
       coef=flip(polyfit(x,log(y),1));
       estimParam(1)=exp(coef(1)); estimParam(2)=-coef(2);
       lim=limits(estimParam);
       if (optimMethod==1)
         f_min=@(x,p) p(1).*exp(-x.*p(2));
       else
         f_min=@(p)f_bounded_powell_nm(p,x,y,lim,selectedModel)
       endif
       case 2 %Equation 2
       f=@(p) p(1).*exp(-x.*p(2)+p(3).*(x.^2));
       f_plot=@(p) p(1).*exp(-x_plot.*p(2)+p(3).*(x_plot.^2));
       coef=flip(polyfit(x,log(y),2));
       estimParam(1)=exp(coef(1)); estimParam(2)=-coef(2); estimParam(3)=coef(3);
       lim=limits(estimParam);
       if (optimMethod==1)
         f_min=@(x,p)p(1).*exp(-x.*p(2)+p(3).*x.^2);
       else
         f_min=@(p)f_bounded_powell_nm(p,x,y,lim,selectedModel)
       endif
       case 3 %Equation 3
      f=@(p) p(1).*exp(-p(2).*(x./(1+p(3).*x)));
      f_plot=@(p) p(1).*exp(-p(2).*(x_plot./(1+p(3).*x_plot)));
      coef=flip(polyfit(x,log(y),2));
      estimParam(1)=exp(coef(1)); estimParam(2)=-coef(2); estimParam(3)=-coef(3)/coef(2);
      lim=limits(estimParam);
      if (optimMethod==1)
        f_min=@(x,p) p(1).*exp(-p(2).*(x./(1+p(3).*x)));
      else
        f_min=@(p)f_bounded_powell_nm(p,x,y,lim,selectedModel)
      endif
      case 4 %Equation 4
      f=@(p) [p(1).*(1+p(3).*x).^2].*exp(-(p(2).*(x./(1+p(3).*x))));
      f_plot=@(p) [p(1).*(1+p(3).*x_plot).^2].*exp(-(p(2).*(x_plot./(1+p(3).*x_plot))));
      coef=flip(polyfit(x,log(y),2));
      estimParam(1)=exp(coef(1)); estimParam(2)=-coef(2); estimParam(3)=-coef(3)/coef(2);
      lim=limits(estimParam);
      if (optimMethod==1)
        f_min=@(x,p) [p(1).*(1+p(3).*x).^2].*exp(-(p(2).*(x./(1+p(3).*x))));
      else
        f_min=@(p)f_bounded_powell_nm(p,x,y,lim,selectedModel);
      endif
      case 5 %Equation 5
      f=@(p) (p(1).*x).^(-p(2));
      f_plot=@(p) (p(1).*x_plot).^(-p(2));
      coef=polyfit(x,(1./y),1);
      estimParam(1)=coef(1); estimParam(2)=1;
      lim=limits(estimParam);
      if (optimMethod==1)
        f_min=@(x,p) (p(1).*x).^(-p(2));
      else
        f_min=@(p)f_bounded_powell_nm(p,x,y,lim,selectedModel);
      endif
     case 6 %Equation 6
      f=@(p) (p(1)+p(2).*x).^(-p(3));
      f_plot=@(p) (p(1)+p(2).*x_plot).^(-p(3));
      coef=flip(polyfit(x,(1./y),1))
      estimParam(1:2)=coef; estimParam(3)=1;
      lim=limits(estimParam);
      if (optimMethod==1)
       f_min=@(x,p) (p(1)+p(2).*x).^(-p(3));
      else
       f_min=@(p)f_bounded_powell_nm(p,x,y,lim,selectedModel);
      endif
      case 7 %Equation 7
      f=@(p) p(1)./[(1+(p(3)-1)*p(2)*exp([p(3)-1]*log(p(1))).*x).^(1/(p(3)-1))];
      f_plot=@(p) p(1)./[(1+(p(3)-1)*p(2)*exp([p(3)-1]*log(p(1))).*x_plot).^(1/(p(3)-1))];
      coef=polyfit(x,log(y),1);
      estimParam(1)=exp(coef(1)); estimParam(2)=-coef(2);estimParam(3)=1.1;
      lim=limits(estimParam);
      if (optimMethod==1)
        f_min=@(x,p) p(1)./[(1+(p(3)-1).*p(2).*x.*exp((p(3)-1).*log(p(1)))).^(1./(p(3)-1))];
      else
        f_min=@(p)f_bounded_powell_nm(p,x,y,lim,selectedModel);
      endif
      case 8 %Equation 8
      f=@(p)[p(1)]./(1+p(2).*x);
      f_plot=@(p)[p(1)]./(1+p(2).*x_plot);
      coef=flip(polyfit(x,1./y,1));
      estimParam(1)=1/coef(1);estimParam(2)=coef(2)*estimParam(1);
      lim=limits(estimParam);
      if (optimMethod==1)
         f_min=@(x,p) p(1)./(1+p(2).*x);
      else
         f_min=@(p)f_bounded_powell_nm(p,x,y,lim,selectedModel);
      endif
      otherwise
      msgbox("An error ocurred in the selection of the model.");
    endswitch
  close;
  end
