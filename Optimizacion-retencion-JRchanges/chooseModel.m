function selectedModel=chooseModel(modelType)
   if modelType==1
    image="UnivariantRetModels.png";
    models=imread(image);
    imshow(models); %Displaying retention models according to modelType
    %waitforbuttonpress();
    msgbox("Select an equation.");
    selectedModel=menu("HPLC retention models:","1","2","3","4","5","6","7","8");
   elseif modelType==2
    image="BivariantRetModels.png";
    models=imread(image);
    imshow(models); %Displaying retention models according to modelType
    %waitforbuttonpress();
    selectedModel=menu("Additive present retention models:","1","2","3","4","5","6");
   endif
  end

