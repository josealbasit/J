function A=loadFile(file) %Loading user-provided retention file
        %Alternative methods to load the desired file...
        %A=csvread(file);
        %A=dlmread(file, " ", headers)
        A=importdata(file,",",0); % A is the matrix containing retention data... file has to be either CSV or UTF-8 .txt(Octave dos not support other types of encoding)
end
