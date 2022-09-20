function [f_min,f_plot,f,empiricalParam]=prepareBiModel(x,x1,x2,z,w,X,Y,selectedModel,optimMethod)

 switch (selectedModel) %Choosing the model...
    case 1
    %Equation 1
      f=@(p) p(1)./(1+p(2).*x1+p(3).*x2+p(4).*x1.*x2);
      f_plot=@(p) p(1)./(1+p(2).*X+p(3).*Y+p(4).*X.*Y);
      if (optimMethod == 1)
      f_min=@(x,p) p(1)./(1+p(2).*x(:,1)+p(3).*x(:,2)+p(4).*x(:,1).*x(:,2));
      else
      f_min=@(p) sumsq(z-p(1)./(1+p(2).*x1+p(3).*x2+p(4).*x1.*x2));
    endif
      coef=(regress(1./z,[w,x1,x2,x1.*x2]));
      empiricalParam(1)=inv(coef(1)); empiricalParam(2)=coef(2)*empiricalParam(1); empiricalParam(3)=coef(3)*empiricalParam(1); empiricalParam(4)=coef(4)*empiricalParam(1);
    case 2
    %Equation 2
      f=@(p) p(1)./(1+p(2).*x1+p(3).*x2+p(4).*x1.*x2+p(5).*x1.*(sqrt(x2)));
      f_plot=@(p) p(1)./(1+p(2).*X+p(3).*Y+p(4).*X.*Y+p(5).*X.*(sqrt(Y)));
      if (optimMethod == 1)
      f_min=@(x,p) p(1)./(1+p(2).*x(:,1)+p(3).*x(:,2)+p(4).*x(:,1).*x(:,2)+p(5).*x(:,1).*(sqrt(x(:,2))));
      else
      f_min=@(p) sumsq(z-p(1)./(1+p(2).*x1+p(3).*x2+p(4).*x1.*x2+p(5).*x1.*(sqrt(x2))));
      endif
      coef=(regress(1./z,[w x1 x2 x1.*x2 x1.*sqrt(x2)]));
      empiricalParam(1)=inv(coef(1)); empiricalParam(2)=coef(2)*empiricalParam(1); empiricalParam(3)=coef(3)*empiricalParam(1); empiricalParam(4)=coef(4)*empiricalParam(1); empiricalParam(5)=coef(5)*empiricalParam(1);
    case 3
    %Equation 3
      f=@(p)[p(1)./(1+p(2).*x2)]./[1+p(3).*[(1+p(4).*x2)./(1+p(2).*x2)].*x1];
      f_plot=@(p)[p(1)./(1+p(2).*Y)]./[1+p(3).*[(1+p(4).*Y)./(1+p(2).*Y)].*X];
      if (optimMethod==1)
        f_min=@(x,p)[p(1)./(1+p(2).*x(:,2))]./[1+p(3).*[(1+p(4).*x(:,2))./(1+p(2).*x(:,2))].*x(:,1)];
      else
        f_min=@(p)sumsq(z-[p(1)./(1+p(2).*x2)]./[1+p(3).*[(1+p(4).*x2)./(1+p(2).*x2)].*x1]);
      endif
      %coef=(regress(1./z,[w x1 x2]));
      empiricalParam(1)=1000; empiricalParam(2)=0.01; empiricalParam(3)=100; empiricalParam(4)=0.2;
    case 4
    %Equation4
      f=@(p)[[p(1).*(1+p(5).*x2)]./(1+p(2).*x2)]./[1+p(3).*[(1+p(4).*x2)./(1+p(2).*x2)].*x1];
      f_plot=@(p)[[p(1).*(1+p(5).*Y)]./(1+p(2).*Y)]./[1+p(3).*[(1+p(4).*Y)./(1+p(2).*Y)].*X];
      if (optimMethod==1)
        f_min=@(x,p)[[p(1).*(1+p(5).*x(:,2))]./(1+p(2).*x(:,2))]./[1+p(3).*[(1+p(4).*x(:,2))./(1+p(2).*x(:,2))].*x(:,1)];
      else
        f_min=@(p) sumsq(z-[[p(1).*(1+p(5).*x2)]./(1+p(2).*x2)]./[1+p(3).*[(1+p(4).*x2)./(1+p(2).*x2)].*x1]);
      endif
      coef=(regress(1./z,[w x1 x2 x1.*x2]));
      empiricalParam(1)=inv(coef(1)); empiricalParam(2)=coef(2)*empiricalParam(1); empiricalParam(3)=coef(3)*empiricalParam(1); empiricalParam(4)=[coef(4)*empiricalParam(1)]/empiricalParam(3); empiricalParam(5)=0;
      %empiricalParam(1)=1000; empiricalParam(2)=0.01; empiricalParam(3)=100; empiricalParam(4)=0.2; empiricalParam(5)=-1;
    case 5
    %Equation 5
      f=@(p)[p(1).*(1+p(6).*x2)]...
      ./[1+p(4).*x1+p(2).*x2+p(3).*x2.^2+p(4).*p(5).*x1.*x2];
      f_plot=@(p)[p(1).*(1+p(6).*Y)]...
      ./[1+p(4).*X+p(2).*Y+p(3).*Y.^2+p(4).*p(5).*X.*Y];
      if (optimMethod==1)
        f_min=@(x,p)[p(1).*(1+p(6).*x(:,2))]...
      ./[1+p(4).*x(:,1)+p(2).*x(:,2)+p(3).*x(:,2).^2+p(4).*p(5).*x(:,1).*x(:,2)];
      else
      f_min=@(p)sumsq(z-[p(1).*(1+p(6).*x2)]...
      ./[1+p(4).*x1+p(2).*x2+p(3).*x2.^2+p(4).*p(5).*x1.*x2])
      endif
      coef=regress(1./z,[w x1 x2 x2.^2 x1.*x2]);
      empiricalParam(1)=inv(coef(1)); empiricalParam(2)=coef(3)*empiricalParam(1); empiricalParam(3)=coef(4)*empiricalParam(1); empiricalParam(4)=coef(2)*empiricalParam(1); empiricalParam(5)=[coef(5)*empiricalParam(1)]/empiricalParam(4); empiricalParam(6)=0;
    case 6
    %Equation 6
      f=@(p)[p(1)]./[1+p(6).*[(1+p(4).*x2+p(5).*x2.^2)./(1+p(2).*x2+p(3).*x2.^2)].*x1];
      f_plot=@(p)[p(1)]./[1+p(6).*[(1+p(4).*Y+p(5).*Y.^2)./(1+p(2).*Y+p(3).*Y.^2)].*X];
      if (optimMethod==1)
        f_min=@(x,p)[p(1)]./[1+p(6).*[(1+p(4).*x(:,2)+p(5).*x(:,2).^2)./(1+p(2).*x(:,2)+p(3).*x(:,2).^2)].*x(:,1)];
      else
        f_min=@(p) sumsq(z-[p(1)]./[1+p(6).*[(1+p(4).*x2+p(5).*x2.^2)./(1+p(2).*x2+p(3).*x2.^2)].*x1]);
      endif
      coef=(regress(1./z,[w x1 x2]));
      empiricalParam(1)=inv(coef(1)); empiricalParam(2)=coef(2)*coef(1); empiricalParam(3)=coef(3)*coef(1); empiricalParam(4:6)=[0 0 0];
  endswitch
  close;

end
