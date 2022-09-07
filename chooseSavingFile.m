function [savingFileName,savingFilePath]=chooseSavingFile(desktopDir) %This function checks wether the saving file exists or not...
         [savingFileName,savingFilePath,fase_ltidx0]=uigetfile("Select associated saving file..."); %Buscamos el archivo en la carpeta asociada a la fase móvil.
         fileExists=isnumeric(savingFileName);
         if fileExists==1 %Creating headers if file does not exist...
           xKey = cell(1, 5); %xKey is cell type containing headers...
           xKey{1,1} = "Date";
           xKey{1,2} = "Compound";
           xKey{1,3} = "R^2";
           xKey{1,4} = "Relative Error";
           xKey{1,5} = "Optimized model Parameters";
           options="Previous data ";
           correctFileName=false;
           while (correctFileName==false)
                  cellFileName=inputdlg(options, "Select saving file name.. "); %User  given file name...
              if (isempty(cellFileName)==1)
                  disp("Error! Please try again!");
              else
                  if(isempty(cellFileName{1,1}))
                     disp("Empty name, please try again!");
                  else
                     correctFileName=true;
                  endif
              endif
           endwhile
           savingFileName=cellFileName{1,1};
           fileFullName=[savingFileName ".csv"];
           cell2csv(fileFullName,xKey); %Using cell2csv() function from IO package...
           mkdir(desktopDir,"Data");
           savingFilePath=[desktopDir "/Data"];
           movefile(fileFullName,savingFilePath);%Moving file to directory...
           savingFileName=fileFullName;
        endif
         if fileExists==0 %File exists...
           disp("Perfect, optimized parameters will be stored in the already existing file!")
         end
end
