function ui_interface(selectedModel,x,x_plot,y0,f_min,f,f_plot,initParam)
selectedModelstr=num2str(selectedModel);
close all
clear h

graphics_toolkit qt

h.ax = axes ("position", [0.05 0.42 0.5 0.5]);
h.fcn = @(p) f([initParam]);

function update_plot (obj, init = false)

  ## gcbo holds the handle of the control
  h = guidata (obj);
  replot = false;
  recalc = false;
  switch (gcbo)
    case {h.print_pushbutton}
      fn =  uiputfile ("*.png");
      print (fn);
    case {h.grid_checkbox}
      v = get (gcbo, "value");
      grid (merge (v, "on", "off"));
    case {h.minor_grid_toggle}
      v = get (gcbo, "value");
      grid ("minor", merge (v, "on", "off"));
    case {h.plot_title_edit}
      v = get (gcbo, "string");
      set (get (h.ax, "title"), "string", v);
    case {h.p1_slider}
      recalc = true;
    case {h.p2_slider}
      recalc = true;
  endswitch

  if (recalc || init)
    p1 = get (h.p1_slider, "value");
    p2 = get (h.p2_slider, "value");
    set (h.p1_label, "string", sprintf ("Parameter 1", p1));
    set (h.p2_label, "string", sprintf ("Parameter 2", p2));
    p1
    p2=initParam(2);
    p3=initParam(3);
    initParam
    x
    y0=f_min([initParam])
    f(initParam)
    [optimParam r2 errorVector errorOptim]=optimizationProcess(x,y0,f_min,f,[p1 p2 p3],2)
    f(optimParam)
    y_optim_plot=f_plot(optimParam);
    if (init)
      %h.plot = plot (x, y, "b");
      %hold on
      "hola"
      initParam 
      f_plot
      y_no_optim_plot=f_plot(initParam)
      h.plot = plot (x , y0,'+');
      hold on
      h.plot = plot(x_plot,y_no_optim_plot,'r')
      guidata (obj, h);
    else
      h.plot=plot(x_plot, y_optim_plot,'b');
      %set (h.plot, "ydata", y);
    endif
  endif

  if (replot)
    cb_red = get (h.linecolor_radio_red, "value");
    lstyle = get (h.linestyle_popup, "string"){get (h.linestyle_popup, "value")};
    lstyle = strtrim (lstyle(1:2));

    mstyle = get (h.markerstyle_list, "string"){get (h.markerstyle_list, "value")};
    if (strfind (mstyle, "none"))
      mstyle = "none";
    else
      mstyle = mstyle(2);
    endif

    set (h.plot, "color", merge (cb_red, [1 0 0 ], [0 0 1]),
                 "linestyle", lstyle,
                 "marker", mstyle);
  endif

endfunction


## plot title
if (selectedModel==1)
  equationName="LSS";
  
endif

h.plot_title_label = uicontrol ("style", "text",
                                "units", "normalized",
                                "string", equationName,
                                "horizontalalignment", "left",
                                "position", [0.6 0.85 0.35 0.08]);

h.plot_title_edit = uicontrol ("style", "edit",
                               "units", "normalized",
                               "string", ["Equation " selectedModelstr],
                               "callback", @update_plot,
                               "position", [0.6 0.80 0.35 0.06]);

## grid
h.grid_checkbox = uicontrol ("style", "checkbox",
                             "units", "normalized",
                             "string", "show grid\n(checkbox)",
                             "value", 0,
                             "callback", @update_plot,
                             "position", [0.6 0.65 0.35 0.09]);

h.minor_grid_toggle = uicontrol ("style", "togglebutton",
                                 "units", "normalized",
                                 "string", "minor\n(togglebutton)",
                                 "callback", @update_plot,
                                 "value", 0,
                                 "position", [0.77 0.65 0.18 0.09]);

## print figure
h.print_pushbutton = uicontrol ("style", "pushbutton",
                                "units", "normalized",
                                "string", "print plot\n(pushbutton)",
                                "callback", @update_plot,
                                "position", [0.6 0.45 0.35 0.09]);
## p1
h.p1_label = uicontrol ("style", "text",
                           "units", "normalized",
                           "string", "Parameter 1",
                           "horizontalalignment", "left",
                           "position", [0.05 0.3 0.35 0.08]);

h.p1_slider = uicontrol ("style", "slider",
                            "units", "normalized",
                            "string", "slider",
                            "callback", @update_plot,
                            "value", initParam(1),
                            "position", [0.05 0.25 0.35 0.06]);
                            
## p1
                           
h.p2_label = uicontrol ("style", "text",
                           "units", "normalized",
                           "string", "Parameter 2",
                           "horizontalalignment", "left",
                           "position", [0.05 0.15 0.35 0.08]);

h.p2_slider = uicontrol ("style", "slider",
                            "units", "normalized",
                            "string", "slider",
                            "callback", @update_plot,
                            "value", initParam(2),
                            "position", [0.05 0.1 0.35 0.06]);
% p3
                           
h.p3_label = uicontrol ("style", "text",
                           "units", "normalized",
                           "string", "Parameter 3",
                           "horizontalalignment", "left",
                           "position", [0.45 0.3 0.35 0.08]);

h.p3_slider = uicontrol ("style", "slider",
                            "units", "normalized",
                            "string", "slider",
                            "callback", @update_plot,
                            "value", initParam(2),
                            "position", [0.45 0.25 0.35 0.06]);

% p4
                           
h.p4_label = uicontrol ("style", "text",
                           "units", "normalized",
                           "string", "Parameter 4",
                           "horizontalalignment", "left",
                           "position", [0.455 0.15 0.35 0.08]);

h.p4_slider = uicontrol ("style", "slider",
                            "units", "normalized",
                            "string", "slider",
                            "callback", @update_plot,
                            "value", initParam(2),
                            "position", [0.45 0.1 0.35 0.06]);       
       
       
## linecolor
%h.linecolor_label = uicontrol ("style", "text",
%                               "units", "normalized",
%                               "string", "Linecolor:",
%                               "horizontalalignment", "left",
%                               "position", [0.05 0.12 0.35 0.08]);
%
%h.linecolor_radio_blue = uicontrol ("style", "radiobutton",
%                                    "units", "normalized",
%                                    "string", "blue",
%%                                    "callback", @update_plot,
%                                    "position", [0.05 0.08 0.15 0.04]);%

%h.linecolor_radio_red = uicontrol ("style", "radiobutton",
 %                                  "units", "normalized",
  %                                 "string", "red",
   %                                "callback", @update_plot,
    %                               "value", 0,
     %                              "position", [0.05 0.02 0.15 0.04]);

## linestyle
%h.linestyle_label = uicontrol ("style", "text",
 %                              "units", "normalized",
  %                             "string", "Linestyle:",
   %                            "horizontalalignment", "left",
    %                           "position", [0.25 0.12 0.35 0.08]);
%
%h.linestyle_popup = uicontrol ("style", "popupmenu",
 %                              "units", "normalized",
  %                             "string", {"-  solid lines",
   %                                       "-- dashed lines",
    %                                      ":  dotted lines",
     %                                     "-. dash-dotted lines"},
      %                         "callback", @update_plot,
       %                        "position", [0.25 0.05 0.3 0.06]);

## markerstyle
%h.markerstyle_label = uicontrol ("style", "text",
 %                                "units", "normalized",
  %                               "string", "Marker style:",
   %                              "horizontalalignment", "left",
    %                             "position", [0.58 0.3 0.35 0.08]);
%
%h.markerstyle_list = uicontrol ("style", "listbox",
 %                               "units", "normalized",
  %                              "string", {"none",
   %                                        "'+' crosshair",
    %                                       "'o'  circle",
     %                                      "'*'  star",
      %                                     "'.'  point",
       %                                    "'x'  cross",
        %                                   "'s'  square",
         %                                  "'d'  diamond",
          %                                 "'^'  upward-facing triangle",
           %                                "'v'  downward-facing triangle",
            %                               "'>'  right-facing triangle",
             %                              "'<'  left-facing triangle",
              %                             "'p'  pentagram",
               %                            "'h'  hexagram"},
                %                "callback", @update_plot,
                 %               "position", [0.58 0.04 0.38 0.26]);

set (gcf, "color", get(0, "defaultuicontrolbackgroundcolor"))
guidata (gcf, h)
update_plot (gcf, true);
waitforbuttonpress()
end