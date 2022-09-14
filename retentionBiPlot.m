function retentionBiPlot(X,Y,f_plot,initParam,optimParam,clearfig)
   z_no_optim_plot=f_plot(initParam);
   z_optim_plot=f_plot(optimParam);
   subplot(1,2,1);
   surf(X,Y,z_no_optim_plot);
   subplot(1,2,2);
   surf(X,Y,z_optim_plot);
   pause(0.1);
   if(clearfig==1)
   clf;
   endif
end
