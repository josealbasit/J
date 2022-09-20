function modelType=checkRetData(A)
  dim=size(A);
  modelType=menu("Your data corresponds to:","L.C. with only one solvent or only one additive!","L.C with additives or two solvents")

  if(modelType==0)
  msgbox("Please enter again retention data, columns of the independent variables must be 2 or 3");
  endif

  end
