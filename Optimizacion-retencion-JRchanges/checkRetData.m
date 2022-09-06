function modelType=checkRetData(A)
  dim=size(A);
  if (dim(2)==2)
  msgbox("Your data corresponds to: Liquid Chromatography with only one solvent or only one additive!");
  modelType=1; %Univariant data
  elseif(dim(2)==3)
  msgbox("Your data corresponds to: Liquid Chromatography in the presence of additives or two solvents");
  modelType=2;%Bivariant data
  else
  msgbox("Please enter again retention data, columns must be 2 or 3");
  modelType=0;
  endif

  end
