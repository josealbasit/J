function retentionUniPlot(x,y,x_plot,f,f_plot,initParam,optimParam,clearfig) %This function plots a comparative graphic between optimized and non-optimized models.

   y_no_optim_plot=f_plot(initParam);
   y_optim_plot=f_plot(optimParam);
   subplot(1,2,1);
   plot(x,y,'o')
   hold on
   plot(x_plot, y_no_optim_plot,'g')
   xlabel("")
   ylabel("")
   legend('Raw data','Non-optimized model for retention')
   title("Non-optimized retention model")
   subplot(1,2,2);
   plot(x,y,'o')
   hold on
   plot(x_plot,y_optim_plot,'r')
   xlabel("")
   ylabel("")
   legend('Raw data','Optimized model for retention')
   title("Retention optimization")
   pause(0.1);
   if(clearfig==1)
   clf;
   endif

end
