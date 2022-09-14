function plotErrorMatrix(errorMatrix,x,y)
  m=rows(errorMatrix);
  n=length(x);
  y0=zeros(1,n);
  figure
  for i=1:m
    plot(x,errorMatrix(i,:),'o')
    hold on
  end
  plot(x,y0,'r')
  hold on
  plot(x,y0,'+')
  xlabel("%")
  ylabel("k")
  legend("Retention prediction error data")
  title("Retention Prediction")
  waitforbuttonpress();
end
