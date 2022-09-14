function [x,x_plot,iterRandom] = defOptimConst(A) %Defines optimization consta
   x=A(:,1);
   eps=(x(end)-x(1))/8;
   x_plot=linspace(x(1)-eps,x(end)+eps,100); %x coordinate to plot discrete data
   iterRandom=10;
  end
