function comparation(x,y,f,D,selectedModel,errorMatrix)
  m=(size(D)(2)-2)/2
  D(:,m+1:2*m)
  f

  y_predicted=f(D(:,m+1:2*m));%evaluation of optim parameters
  y
  y_predicted
 for i=1:length(D)
  plot(y,y_predicted(i,:))
  hold on
 endfor
 figure
 plotErrorMatrix(errorMatrix,x,y)
 endfunction

