function solutes=separateSolutes(A,modelType)
  dim=size(A)(2);
  if(modelType==1)
  solutes=A(:,2:dim)
  elseif(modelType==2)
  solutes=A(:,3:dim)
  endif
endfunction

