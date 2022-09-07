function manualParam=manualParameters(A,selectedModel)
if(or(selectedModel == 1,selectedModel == 5,selectedModel == 6,selectedModel == 8))
  prompt={"Parameter p1","Parameter p2"};
  dlg_title="Manual selection of the initial parameters for optimization";
  num_lines=1;
  p=inputdlg(prompt,dlg_title,num_lines)
  manualParam(1)=str2num(p{1});
  manualParam(2)=str2num(p{2});
elseif(or(selectedModel == 2,selectedModel == 3,selectedModel == 4,selectedModel == 7))
  prompt={"Parameter p1","Parameter p2","Parameter p3"};
  dlg_title="Manual selection of the initial parameters for optimization";
  num_lines=1;
  p=inputdlg(prompt,dlg_title,num_lines)
  manualParam(1)=str2num(p{1});
  manualParam(2)=str2num(p{2});
  manualParam(3)=str2num(p{3});
end
