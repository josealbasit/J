function retentionUniPlot(x,y,f,initParam,optimParam,clearfig) %This function plots a comparative graphic between optimized and non-optimized models.
   %eps=(x(end)-x(1))/8;
   %x_plot=linspace(x(1)-eps,x(end)+eps,100); %x coordinate to plot discrete data
   y_no_optim_plot=f(initParam);
   y_optim_plot=f(optimParam);
   subplot(1,2,1);
   plot(x,y,'o')
   hold on
   plot(x, y_no_optim_plot,'g')
   xlabel("")
   ylabel("")
   legend('Raw data','Non-optimized model for retention')
   title("Non-optimized retention model")
   subplot(1,2,2);
   plot(x,y,'o')
   hold on
   plot(x,y_optim_plot,'r')
   xlabel("")
   ylabel("")
   legend('Raw data','Optimized model for retention')
   title("Retention optimization")
   pause(0.1);
   if(clearfig==1)
   clf;
   endif

end
