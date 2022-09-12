function [x,y,x_plot,iter,iterRandom] = defOptimConst(A) %Defines optimization consta
   x=A(:,1);
   y=A(:,2);
   eps=(x(end)-x(1))/8;
   x_plot=linspace(x(1)-eps,x(end)+eps,100); %x coordinate to plot discrete data
   iter=10;
   iterRandom=10;
  end
