function [fileName, filePath] = introRetentionData(initPath) %Obtenemos el nombre del archivo del cromatograma y su ruta en el ordenador....
   selectFile=true;
   while (selectFile==true)
       [fileName,filePath,fltidx0]=uigetfile(initPath,"Please, select retention data file");
       selectFile=false;
       if(fileName==0) %Pressing cancel drives us back to choosing the file...
          msgbox("Error! You must select a file.");
          selectFile=true;
       endif
   endwhile
endfunction
