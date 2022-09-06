function [f_no_optim]=comparationPlot(f,f1,t,y,t_modified,initParam)

%Comparation between optimized and non-optimized function...
   f_no_optim=f(t_modified,initParam);
   subplot(2,2,1);
   plot(t(1:8:end),y(1:8:end),'o')
   hold on
   plot(t_modified, f_no_optim,'g')
   xlabel("Time")
   ylabel("Signal")
   legend('Signal Data','Non optimized parameters Signal')
   title("Non-optimized parameters Peak Evaluation")

   subplot(2,2,2);
   plot(t(1:8:end),y(1:8:end),'o')
   hold on
   plot(t_modified,f1,'r')
   xlabel("Time")
   ylabel("Signal")
   legend('Signal Data','Optimized parameters Signal')
   title("Optimized parameters Peak Evaluation")

   subplot(2,2,[3,4]);
   plot(t(1:8:end),y(1:8:end),'o')
   hold on
   plot(t_modified, f_no_optim,'g')
   hold on
   plot(t_modified,f1,'r')
   xlabel("Time")
   ylabel("Signal")
   legend('Signal Data','Non optimized parameters Signal', 'Optimized parameters Signal')
   title("Optimized VS Non-optimized Signal")
end
