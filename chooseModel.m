function selectedModel=chooseModel(modelType)
   if modelType==1
    image="UnivariantRetModels.png";
    models=imread(image);
    imshow(models); %Displaying retention models according to modelType
    %waitforbuttonpress();
    msgbox("Select an equation.");
    selectedModel=menu("HPLC retention models:","1. LSS","2. QSS","3. Neue / Polarity","4. Neue-Kuss","5. Jandera 2p","6. Jandera 3p","7. Elution g","8. Micelar ");
   elseif modelType==2
    image="BivariantRetModels.png";
    models=imread(image);
    imshow(models); %Displaying retention models according to modelType
    %waitforbuttonpress();
    selectedModel=menu("Additive present retention models:","1","2","","4","5","6");
   endif
  end

