function [p1,r21,iter1,error_no_optim,error_optim]=additive_univariant_ret_opt(A)

  %This function uses Levenberg-Marquadt optimization method to find the optimum value for a given set of data,
  %This code is intended to deal with mathematical models which describe retention in the PRESENCE OF ADDITIVES.
   paquetes(); %We use leasqr funtion in GNU Octave, present in optim package.
   x=A(:,1); y=A(:,2); %A is the matrix containing the experimental dataset.
   modelos=imread("im_modelos.png");
   imshow(modelos); %Displaying retention models in an image.
   waitforbuttonpress();
   X=menu("Models of retention in the presence of additives:","1"); %Confirmamos el intervalo o elegimos uno nuevo
   switch (X)
    case 1
      f_leasqr=@(x,p)[p(1)]./(1+p(2).*x); %This is the function we'll use to describe retention.
      coef=flip(polyfit(x,(1./y),1));%To estimate initial parameters for the model, we use polyfit function in OCTAVE, i.e, least square lineal regression.
      p_init(1)=inv(coef(1)); p_init(2)=coef(2)*coef(1); %We now assign the transformed coeficients to our desired initial parameters.
    otherwise
      disp("An error ocurred in the selection of the model.")
   endswitch
   global verbose; verbose = false;
   [f1, p1, kvg1, iter1, corp1, covp1, covr1, stdresid1, Z1, r21] = leasqr (x, y, p_init, f_leasqr);
   eps=(x(end)-x(1))/8;
   x_plot=linspace(x(1)-eps,x(end)+eps,100);
   %Graphics to compare optimization. LEFT, model with intial guesses; RIGHT, models with optimized parameters.
   y_no_optim=f_leasqr(x, p_init);
   error_no_optim=sumsq(y-y_no_optim)/sumsq(y);
   error_optim=sumsq(y-f1)/sumsq(y);
   y_no_optim_plot=f_leasqr(x_plot, p_init);
   y_optim_plot=f_leasqr(x_plot,p1);
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

endfunction
