 function estimParameters=generateEstimParameters (estimParam,iterRandom)
  %This function generates a randomParameter matrix based on an initial empirical approximation.
  %It is aimed to deal with non-lineal retention equations.
  %empiricalParam is an optimized approximation carried out using
  %empirical information
  %Generation of initial  Parameters in a radius of .75estimParam
  m=length(estimParam);
  randomParameters=zeros(m,iterRandom); %random parameters matrix
  for i=1:m
    estimParameters(i,1:iterRandom-1)=estimParam(i).*(1.5*rand(1,iterRandom-1)+.25);
  end
  estimParameters(:,iterRandom)=estimParam';
 end
