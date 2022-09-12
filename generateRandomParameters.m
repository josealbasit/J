 function randomParameters=generateRandomParameters (empiricalParam,iterRandom)
  %This function generates a randomParameter matrix based on an initial empirical approximation.
  %It is aimed to deal with non-lineal retention equations.
  %empiricalParam is an optimized approximation carried out using
  %empirical information
  m=length(empiricalParam);
  randomParameters=zeros(m,iterRandom); %random parameters matrix
  for i=1:m
    randomParameters(i,1:iterRandom-1)=empiricalParam(i).*(4*rand(1,iterRandom-1)-1); %2 times empirical param radius of search
  end
  randomParameters(:,iterRandom)=empiricalParam';
 end
