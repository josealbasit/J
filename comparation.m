function comparation(x,y,f,D,errorMatrix)
  close all;
  m=(size(D)(2)-2)/2;
  A=D(:,m+1:2*m);
  plot(y,y,'r');
  hold on
  plot(y,y,'+')
  hold on
  for i=1:rows(D)
   y_predicted=f(A(i,:));
   plot(y,y_predicted,'o')
   hold on
  endfor
  xlabel("k")
  ylabel("predicted k")
  legend("Retention data")
  title("Retention Prediction")
  waitforbuttonpress();
endfunction

