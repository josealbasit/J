function [initialDir, desktopDir]=directories() %Defining some directories and paths...
  initialDir=pwd;
  cd ..;
  desktopDir=pwd;
  cd(initialDir);
end
