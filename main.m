function main()
  packages(); %Loading forge packages...
  selectNewData=true;
  while (selectNewData==true) %While we want to optimize new data...
    [modelType,changeRetModel,selectNewData,counterModel,compound,counterData,bestError,optimMethod] = mainConstants(); %Initial constants...
    [initialDir, desktopDir]=directories(); %Directories...
    while (modelType == 0)
      [fileName, filePath]=introRetentionData(desktopDir) %Get file name and path...
      addpath(filePath); %Add current file path
      A=loadFile(fileName); %Loading file to the system...
      modelType=checkRetData(A); %Checking which models we can use, i.e, dimension of the matrix...
    endwhile
%Until now, we have selected the data file. Now we need an equation to model the data and an optimization method to
%optimize parameters.
    while (changeRetModel == true)
    selectedModel=chooseModel(modelType);
    errorMatrix=zeros(3*10+3,rows(A));%Error matrix to perform outlier detection later on
    %optimMethod=menu("Select an optimization method:","Levenberg-Marquadt","Nelder-Mead","Powell");
    if(modelType==1)
         [bestParam,x,y]=univariantRetOptim(A,selectedModel,optimMethod,errorMatrix)
    elseif(modelType==2)
       for i=1:3
         optimMethod=i;
         finalParam=bivariantRetOptim(A,selectedModel,optimMethod)
           if(finalParam(length(finalParam)-1) < bestError)
           bestError=finalParam(length(finalParam)-1);
           bestParam=finalParam;
           endif
       endfor
    endif
    close all;
    answer=questdlg("Do you want to enter a MANUAL estimation of initial parameters and perform an optimization?")
    if (length(answer)== 3)
      manualParam=manualParameters(A,selectedModel,modelType)
      optimManualParam=manualOptimization(A,manualParam,selectedModel,modelType)
    endif
%Corresponds to saving code...
% if (counterData == 0)
% [savingFileName,savingFilePath]=chooseSavingFile(desktopDir);
%endif
%saveOptimParam([param_optim',r2,error_optim],counterModel,compound,savingFileName,savingFilePath,initialDir); %Saving parameteres in an Excel file .xlsx
%parameterSaving([param_optim',r2,error_optim],counterModel,compound,fileName,filePath,initialDir);
    whatNext=menu("Select an option!"," Change retention model ", "Select new data" , "Close program"); %What to do next....
    switch (whatNext)
      case 1 %Change retention model using the same data...
        close all;
        counterModel=counterModel+1;
      case 2 %Change data and start again...
        changeRetModel=false;
        counterModel=0;
        close all;
      case 3 %Close program...
        changeRetModel=false;
        selectNewData=false;
        close all;
        msgbox("Bye bye! Ens veiem!")
    endswitch
    endwhile
  endwhile
end
