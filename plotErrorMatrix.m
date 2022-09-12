function plotErrorMatrix(errorMatrix,x,y)
  m=rows(errorMatrix);
  for i=1:m
    plot(x,errorMatrix(i,:),'o')
    hold on
  end
  plot(x,y)
  xlabel("%")
  ylabel("k")
  legend("Retention prediction data")
  title("Retention Prediction")
  waitforbuttonpress();
end
