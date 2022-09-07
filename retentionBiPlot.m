function retentionBiPlot(X,Y,z_no_optim_plot,z_optim_plot)
   subplot(1,2,1);
   surf(X,Y,z_no_optim_plot);
   subplot(1,2,2);
   surf(X,Y,z_optim_plot);
   waitforbuttonpress();
end
