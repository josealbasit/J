 function escribir_parametros_fichero(w,file)
         m=16;
         xKey = cell(m, 1);
         fecha=clock(); %la función clock devuelve la fecha actual
         compuesto=inputdlg("Nombre del compuesto", "Introduce el nombre del compuesto asociado al pico: ");
         xKey{2,1}=compuesto{1,1};
         for i=3:m
             xKey{i,1}=w(i-2);
         endfor
         nombre_fichero=[file ".txt"];
         outfile = fopen(nombre_fichero, "a"); %Abre(o crea) un fichero y escribe encima de el
         for i=1:5
                 fprintf(outfile, "%d", fecha(i));%d es para escribir enteros
                 if i<3
                      fprintf(outfile, "%s", "/");
                 endif
                 if i==3
                     fprintf(outfile, "%s", "  ");
                 endif
                 if i==4
                      fprintf(outfile, "%s", ":");
                 endif
         endfor
         fprintf(outfile, "%s", ",");
         fprintf(outfile, "%c", xKey{2,1})
         fprintf(outfile, "%s", ",");
         for i=3:m,
             %fprintf(outfile, "%s\n", xKey{i,1}); % %s sirve para que escriba un string
             fprintf(outfile, "%d", xKey{i,1});%d es para escribir enteros
             if i<m
                  fprintf(outfile, "%s", ",");
             endif
         end
         fprintf(outfile, "%s\n", " ");
         fflush(outfile);
         fclose(outfile);
         disp("El orden de los parámetros es: t_R,H_0,A_10,A_60,B_60,B_10,Área,Tiempo medio, Varianza,Asimetria")
end

