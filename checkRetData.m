function modelType=checkRetData(A)
  dim=size(A);
  modelType=menu("Your data corresponds to:","Liquid Chromatography with only one solvent or only one additive!","Liquid Chromatography in the presence of additives or two solvents")

  if(modelType==0)
  msgbox("Please enter again retention data, columns must be 2 or 3");
  endif

  end
