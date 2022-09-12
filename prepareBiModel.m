function [f,f_plot,f_error,estimParam]=prepareBiModel(x,x1,x2,z,w,X,Y,selectedModel,optimMethod)

 switch (selectedModel) %Choosing the model...
    case 1
    %Equation 1
      f_error=@(p) p(1)./(1+p(2).*x1+p(3).*x2+p(4).*x1.*x2);
      f_plot=@(p) p(1)./(1+p(2).*X+p(3).*Y+p(4).*X.*Y);
      if (optimMethod == 1)
      f=@(x,p) p(1)./(1+p(2).*x(:,1)+p(3).*x(:,2)+p(4).*x(:,1).*x(:,2));
      else
      f=@(p) sumsq(z-p(1)./(1+p(2).*x1+p(3).*x2+p(4).*x1.*x2));
      endif
      coef=(regress(1./z,[w,x1,x2,x1.*x2]));
      estimParam(1)=inv(coef(1)); estimParam(2)=coef(2)*estimParam(1); estimParam(3)=coef(3)*estimParam(1); estimParam(4)=coef(4)*estimParam(1);
    case 2
    %Equation 2
      f_error=@(p) p(1)./(1+p(2).*x1+p(3).*x2+p(4).*x1.*x2+p(5).*x1.*(sqrt(x2)));
      f_plot=@(p) p(1)./(1+p(2).*X+p(3).*Y+p(4).*X.*Y+p(5).*X.*(sqrt(Y)));
      if (optimMethod == 1)
      f=@(x,p) p(1)./(1+p(2).*x(:,1)+p(3).*x(:,2)+p(4).*x(:,1).*x(:,2)+p(5).*x(:,1).*(sqrt(x(:,2))));
      else
      f=@(p) sumsq(z-p(1)./(1+p(2).*x1+p(3).*x2+p(4).*x1.*x2+p(5).*x1.*(sqrt(x2))));
      endif
      coef=(regress(1./z,[w x1 x2 x1.*x2 x1.*sqrt(x2)]));
      estimParam(1)=inv(coef(1)); estimParam(2)=coef(2)*estimParam(1); estimParam(3)=coef(3)*estimParam(1); estimParam(4)=coef(4)*estimParam(1); estimParam(5)=coef(5)*estimParam(1);
    case 3
    %Equation 3
      f_error=@(p)[p(1)./(1+p(2).*x2)]./[1+p(3).*[(1+p(4).*x2)./(1+p(2).*x2)].*x1];
      f_plot=@(p)[p(1)./(1+p(2).*Y)]./[1+p(3).*[(1+p(4).*Y)./(1+p(2).*Y)].*X];
      if (optimMethod==1)
        f=@(x,p)[p(1)./(1+p(2).*x(:,2))]./[1+p(3).*[(1+p(4).*x(:,2))./(1+p(2).*x(:,2))].*x(:,1)];
      else
        f=@(p)sumsq(z-[p(1)./(1+p(2).*x2)]./[1+p(3).*[(1+p(4).*x2)./(1+p(2).*x2)].*x1]);
      endif
      %coef=(regress(1./z,[w x1 x2]));
      estimParam(1)=1000; estimParam(2)=0.01; estimParam(3)=100; estimParam(4)=0.2;
    case 4
    %Equation4
      f_error=@(p)[[p(1).*(1+p(5).*x2)]./(1+p(2).*x2)]./[1+p(3).*[(1+p(4).*x2)./(1+p(2).*x2)].*x1];
      f_plot=@(p)[[p(1).*(1+p(5).*Y)]./(1+p(2).*Y)]./[1+p(3).*[(1+p(4).*Y)./(1+p(2).*Y)].*X];
      if (optimMethod==1)
        f=@(x,p)[[p(1).*(1+p(5).*x(:,2))]./(1+p(2).*x(:,2))]./[1+p(3).*[(1+p(4).*x(:,2))./(1+p(2).*x(:,2))].*x(:,1)];
      else
        f=@(p) sumsq(z-[[p(1).*(1+p(5).*x2)]./(1+p(2).*x2)]./[1+p(3).*[(1+p(4).*x2)./(1+p(2).*x2)].*x1]);
      endif
      coef=(regress(1./z,[w x1 x2 x1.*x2]));
      estimParam(1)=inv(coef(1)); estimParam(2)=coef(2)*estimParam(1); estimParam(3)=coef(3)*estimParam(1); estimParam(4)=[coef(4)*estimParam(1)]/estimParam(3); estimParam(5)=0;
      %estimParam(1)=1000; estimParam(2)=0.01; estimParam(3)=100; estimParam(4)=0.2; estimParam(5)=-1;
    case 5
    %Equation 5
      f_error=@(p)[p(1).*(1+p(6).*x2)]...
      ./[1+p(4).*x1+p(2).*x2+p(3).*x2.^2+p(4).*p(5).*x1.*x2];
      f_plot=@(p)[p(1).*(1+p(6).*Y)]...
      ./[1+p(4).*X+p(2).*Y+p(3).*Y.^2+p(4).*p(5).*X.*Y];
      if (optimMethod==1)
        f=@(x,p)[p(1).*(1+p(6).*x(:,2))]...
      ./[1+p(4).*x(:,1)+p(2).*x(:,2)+p(3).*x(:,2).^2+p(4).*p(5).*x(:,1).*x(:,2)];
      else
      f=@(p)sumsq(z-[p(1).*(1+p(6).*x2)]...
      ./[1+p(4).*x1+p(2).*x2+p(3).*x2.^2+p(4).*p(5).*x1.*x2])
      endif
      coef=regress(1./z,[w x1 x2 x2.^2 x1.*x2]);
      estimParam(1)=inv(coef(1)); estimParam(2)=coef(3)*estimParam(1); estimParam(3)=coef(4)*estimParam(1); estimParam(4)=coef(2)*estimParam(1); estimParam(5)=[coef(5)*estimParam(1)]/estimParam(4); estimParam(6)=0;
    case 6
    %Equation 6
      f_error=@(p)[p(1)]./[1+p(6).*[(1+p(4).*x2+p(5).*x2.^2)./(1+p(2).*x2+p(3).*x2.^2)].*x1];
      f_plot=@(p)[p(1)]./[1+p(6).*[(1+p(4).*Y+p(5).*Y.^2)./(1+p(2).*Y+p(3).*Y.^2)].*X];
      if (optimMethod==1)
        f=@(x,p)[p(1)]./[1+p(6).*[(1+p(4).*x(:,2)+p(5).*x(:,2).^2)./(1+p(2).*x(:,2)+p(3).*x(:,2).^2)].*x(:,1)];
      else
        f=@(p) sumsq(z-[p(1)]./[1+p(6).*[(1+p(4).*x2+p(5).*x2.^2)./(1+p(2).*x2+p(3).*x2.^2)].*x1]);
      endif
      coef=(regress(1./z,[w x1 x2]));
      estimParam(1)=inv(coef(1)); estimParam(2)=coef(2)*coef(1); estimParam(3)=coef(3)*coef(1); estimParam(4:6)=[0 0 0];
  endswitch
  close;

end
