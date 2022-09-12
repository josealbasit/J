function [x,x1,x2,z,w,X,Y,iter] = defOptimConstBi(A) %Creating constant needed for optimization...
  x=A(:,1:2);
  z=A(:,3);
  x1=A(:,1);
  x2=A(:,2);
  x_plot=linspace(x1(1),x1(end),50);
  y_plot=linspace(x2(1),x2(end),50);
  [X,Y]=meshgrid(x_plot,y_plot);
  w=repelem(1,length(z))';
  iter=5;
end
