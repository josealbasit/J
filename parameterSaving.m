%Generating file with optimized parameter.
%This function uses a rather low-level coding to write parameteres in a file, instead of using newData
%functions available for Octave. We do this for various reasons related with the nature of the generated data.
%In particular: 1.- Different Matrix length, depending on the selected model.
%2.- Data types: combination of strings and numeric data in parameter vector.
function parameterSaving(w,counterModel,compound,fileName,filePath,initialDir) %Provisional function to write optimized parameters...
         compound;
         cd(filePath); %Go to file path...
         m=length(w);
         newData = cell(1,16); %Creating cell to store parameter values...
         newData{1,1}=datestr(now()); %Getting current date...
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
             newData{i,1}=w(i-2);
         endfor
         outfile = fopen(fileName, "a"); %Open file in append mode...
         %for i=1:5
          %       fprintf(outfile, "%d", fecha(i));%d es para escribir enteros
           %      if i<3
            %          fprintf(outfile, "%s", "/"); %Char writing
             %    endif
              %   if i==3
               %      fprintf(outfile, "%s", "  ");
                % endif
                 %if i==4
                 %     fprintf(outfile, "%s", ":");
                 %endif
         %endfor
         for i=1:2
           fprintf(outfile, "%s", newData{1,i})
           fprintf(outfile, "%s", ",");
         endfor
         for i=3:m-1
             fprintf(outfile, "%d", newData{1,i});% %d is for integer wirting conversion
         end
         fprintf(outfile, "%s", newData{1,i});
         fprintf(outfile, "%s", ",");
         fprintf(outfile, "%s\n", " ");
         fflush(outfile);
         fclose(outfile);
         disp("Data order is: Date, Compound Name, R^2, Error, Parameters.");
         cd(initialDir); %Going to initial directory again...
end

