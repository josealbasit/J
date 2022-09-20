function [x,X,Y,iter] = defOptimConstBi(A) %Creating constant needed for optimization...
  x=A(:,1:2);
  x_plot=linspace(A(:,1)(1),A(:,1)(end),50);
  y_plot=linspace(A(:,2)(1),A(:,2)(end),50);
  [X,Y]=meshgrid(x_plot,y_plot);
  iter=5;
end
