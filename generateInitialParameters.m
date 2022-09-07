function initialParameters=generateInitialParameters(estimParam,iter)
  m=length(estimParam);
  initialParameters=zeros(m,iter); %Initial Parameter Matrix
  for i=1:m
    r(i)=2*estimParam(i); %Radius of the search region for each parameter.
    %maxValue(i)=estimParam(i)+r(i);
    minValue(i)=estimParam(i)-r(i);
    initialParameters(i,:)=2*r(i).*rand(1,iter)+minValue(i);
  end
endfunction
