function saveOptimParam(w,counterModel,compound,fileName,filePath,initialDir) %Esta función escribe en un csv los parámetros obtenidos.
         cd(filePath); %Go to file path...
         data=csv2cell(fileName) %Store data in csv file...
         m=length(w); %Parameter length...
         newData = cell(1, m);
         newData{1,1}=datestr(now()); %datesrt(now()) returns current date...
         if (counterModel == 0)
         introCompound=false;
         while (introCompound ==false)
              compound=inputdlg("Compound name",["Introduce compound name here. "]); %User writes compound name if its the first time...
              if (isempty(compound)==1)
                  disp("Error! Please try again!");
              else
                  if(isempty(compound{1,1}))
                     disp("Empty name... Please try again!");
                  else
                     introCompound=true;
                  endif
              endif
         endwhile
         endif
         newData{1,2}=compound{1,1};
         for i=3:m
             newData{1,i}=w(i-2); %New data is passed ...
         endfor
         dlmwrite(fileName,newData,"-append");
         %finalData=[data; newData]; %Adding new data to stored ones..
         %cell2csv(fileName,finalData); %Move data to file... (this has been prefered to append() function...
         cd(initialDir); %Going to initial directory again...
         disp("Data order is: Date, Compound Name, R^2, Error, Parameters.")
end
