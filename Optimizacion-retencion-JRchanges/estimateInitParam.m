function estimateInitParam(initParam)
  [y_optim, optimParameters, kvg1, iter1, corp1, covp1, covr1, stdresid1, Z1, r2] = leasqr(x, y, initParam, f); %Applying leasqr () to desired function...
  m=length(initParam);%Number of parameters in the model
  B=zeros(,); %B stores the optimization parameters along with its r2 to establish sensitivity
  k=1;
  maxit=20;
  for l=1:maxit
  for i=1:m
    for j=1:m 
      if (j!=i)
        newInitParam(i,j)= 10*initParam(j)/100 + initParam(j);
        [y_optim, optimParameters, iter1, corp1, covp1, covr1, stdresid1, Z1, r2] = leasqr(x, y, newInitParam, f); %Applying leasqr () to desired function...
        B(k,:)=[initParam, r2];
        k++;
      endif
    endfor
    initParam=
    
  
endfor

  [y_optim, optimParameters, iter1, corp1, covp1, covr1, stdresid1, Z1, r2] = leasqr(x, y, initParam, f); %Applying leasqr () to desired function...
  
  
  
  
  
  
  
  endfunction