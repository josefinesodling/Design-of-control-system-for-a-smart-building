function varargout = SimpleOptimizedTabs2(varargin)
%{
    
    HOW TO CREATE A NEW TAB

    1. Create or copy PANEL and TEXT objects in GUI

    2. Rename tag of PANEL to "tabNPanel" and TEXT for "tabNtext", where N
    - is a sequential number. 
    Example: tab3Panel, tab3text, tab4Panel, tab4text etc.
    
    3. Add to Tab Code - Settings in m-file of GUI a name of the tab to
    TabNames variable

    Version: 1.0
    First created: January 18, 2016
    Last modified: January 18, 2016

    Author: WFAToolbox (http://wfatoolbox.com)

%}

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @SimpleOptimizedTabs2_OpeningFcn, ...
                   'gui_OutputFcn',  @SimpleOptimizedTabs2_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before SimpleOptimizedTabs2 is made visible.
function SimpleOptimizedTabs2_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to SimpleOptimizedTabs2 (see VARARGIN)

% Choose default command line output for SimpleOptimizedTabs2
handles.output = hObject;

%% Tabs Code
% Settings
TabFontSize = 8;
TabNames = {'Floor 4','Floor 3','Tab 3'};
FigWidth = 0.5;

% Figure resize
set(handles.SimpleOptimizedTab,'Units','normalized')
pos = get(handles. SimpleOptimizedTab, 'Position');
set(handles. SimpleOptimizedTab, 'Position', [pos(1) pos(2) FigWidth pos(4)])

% Tabs Execution
handles = TabsFun(handles,TabFontSize,TabNames);

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes SimpleOptimizedTabs2 wait for user response (see UIRESUME)
% uiwait(handles.SimpleOptimizedTab);

% --- TabsFun creates axes and text objects for tabs
function handles = TabsFun(handles,TabFontSize,TabNames)

% Set the colors indicating a selected/unselected tab
handles.selectedTabColor=get(handles.tab1Panel,'BackgroundColor');
handles.unselectedTabColor=handles.selectedTabColor-0.1;

% Create Tabs
TabsNumber = length(TabNames);
handles.TabsNumber = TabsNumber;
TabColor = handles.selectedTabColor;
for i = 1:TabsNumber
    n = num2str(i);
    
    % Get text objects position
    set(handles.(['tab',n,'text']),'Units','normalized')
    pos=get(handles.(['tab',n,'text']),'Position');

    % Create axes with callback function
    handles.(['a',n]) = axes('Units','normalized',...
                    'Box','on',...
                    'XTick',[],...
                    'YTick',[],...
                    'Color',TabColor,...
                    'Position',[pos(1) pos(2) pos(3) pos(4)+0.01],...
                    'Tag',n,...
                    'ButtonDownFcn',[mfilename,'(''ClickOnTab'',gcbo,[],guidata(gcbo))']);
                    
    % Create text with callback function
    handles.(['t',n]) = text('String',TabNames{i},...
                    'Units','normalized',...
                    'Position',[pos(3),pos(2)/2+pos(4)],...
                    'HorizontalAlignment','left',...
                    'VerticalAlignment','middle',...
                    'Margin',0.001,...
                    'FontSize',TabFontSize,...
                    'Backgroundcolor',TabColor,...
                    'Tag',n,...
                    'ButtonDownFcn',[mfilename,'(''ClickOnTab'',gcbo,[],guidata(gcbo))']);

    TabColor = handles.unselectedTabColor;
end
            
% Manage panels (place them in the correct position and manage visibilities)
set(handles.tab1Panel,'Units','normalized')
pan1pos=get(handles.tab1Panel,'Position');
set(handles.tab1text,'Visible','off')


%set(handles.axes3,'Visible','on')


for i = 2:TabsNumber
    n = num2str(i);
    set(handles.(['tab',n,'Panel']),'Units','normalized')
    set(handles.(['tab',n,'Panel']),'Position',pan1pos)
    set(handles.(['tab',n,'Panel']),'Visible','off')
    set(handles.(['tab',n,'text']),'Visible','off')
end

% --- Callback function for clicking on tab
function ClickOnTab(hObject,~,handles)
m = str2double(get(hObject,'Tag'));

for i = 1:handles.TabsNumber;
    n = num2str(i);
    if i == m
        set(handles.(['a',n]),'Color',handles.selectedTabColor)
        set(handles.(['t',n]),'BackgroundColor',handles.selectedTabColor)
        set(handles.(['tab',n,'Panel']),'Visible','on') 
        % ------- Picture in the background (not working yet)---------------------
       % panhandle = uipanel(handles.tab1Panel);
       % panax = axes('Units','normal','DataAspectRatioMode','auto', 'Parent', panhandle);
       % imhandle = imshow('fourth_floor.PNG', 'Parent', panax);
        
    else
        set(handles.(['a',n]),'Color',handles.unselectedTabColor)
        set(handles.(['t',n]),'BackgroundColor',handles.unselectedTabColor)
        set(handles.(['tab',n,'Panel']),'Visible','off') 
    end
end

% --- Outputs from this function are returned to the command line.
function varargout = SimpleOptimizedTabs2_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


%--------------- FROM HERE ADDITIONAL BOTTONS ARE ADDED--------------------

%%% START/STOP SIMULINK

% % --- Executes on button press in start_stop_sim.
% function start_stop_sim_Callback(hObject, eventdata, handles)
% % hObject    handle to start_stop_sim (see GCBO)
% % eventdata  reserved - to be defined in a future version of MATLAB
% % handles    structure with handles and user data (see GUIDATA)
% button_state = get(hObject,'Value');
% if button_state == get(hObject,'Max')
%     set(hObject, 'String', 'Stop Simulation');
%     open('House_model');
%     %getSimulationMetadata?
%     set_param('House_model','simulationcommand','start')
%     %simOut = sim('House_model',[0 20],...
%     %simOut = sim('SimulationMode','normal','AbsTol','1e-5',...'SaveTime','on','TimeSaveName','tout')%, ...
% %             'ZeroCross','on', ...
% %             'SaveState','on','StateSaveName','xoutNew',...
% %             'SaveOutput','on','OutputSaveName','youtNew',...
% %             'SignalLogging','on','SignalLoggingName','logsout')
% elseif button_state == get(hObject,'Min')
%     %     global GUIStopFlag;
%     %     GUIStopFlag = 1;
%     set(hObject, 'String', 'Start Simulation')
%     set_param('House_model','simulationcommand','stop')
% end

%%%%%%%%%%%%%%%% FLOOR 4 %%%%%%%%%%%%%%%%%%%%%%%%

%%% BULBS
% bulb: max 7 Watt, energy/day 0.28 kW total 
% flourecent: max 36 Watt

% --- Executes on button press in F4_bulb1_radio.
function F4_bulb1_radio_Callback(hObject, eventdata, handles)
% hObject    handle to F4_bulb1_radio (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hint: get(hObject,'Value') returns toggle state of F4_bulb1_radio
button_state = get(hObject,'Value');
if button_state == get(hObject,'Max')
    set(handles.F4_bulb1_radio, 'Value', 1);
    set(handles.F4_bulb1_radio,'BackgroundColor','green');
    F4_bulb_1 = 7; % watt
elseif button_state == get(hObject,'Min')
    set(handles.F4_bulb1_radio, 'Value', 0);
    set(handles.F4_bulb1_radio,'BackgroundColor',[0.94 0.94 0.94]);
    F4_bulb_1 = 0; % watt
end
set_param('House_model/Floor_4/Lightening/F4_bulb_1','Value', num2str(F4_bulb_1));

% --- Executes on button press in F4_bulb2_radio.
function F4_bulb2_radio_Callback(hObject, eventdata, handles)
% hObject    handle to F4_bulb2_radio (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hint: get(hObject,'Value') returns toggle state of F4_bulb2_radio
button_state = get(hObject,'Value');
if button_state == get(hObject,'Max')
    set(handles.F4_bulb2_radio, 'Value', 1);
    set(handles.F4_bulb2_radio,'BackgroundColor','green');
    F4_bulb_2 = 7; % watt
elseif button_state == get(hObject,'Min')
    set(handles.F4_bulb2_radio, 'Value', 0);
    set(handles.F4_bulb2_radio,'BackgroundColor',[0.94 0.94 0.94]);
    F4_bulb_2 = 0; % watt
end
set_param('House_model/Floor_4/Lightening/F4_bulb_2','Value', num2str(F4_bulb_2));

% --- Executes on button press in F4_bulb3_radio.
function F4_bulb3_radio_Callback(hObject, eventdata, handles)
% hObject    handle to F4_bulb3_radio (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hint: get(hObject,'Value') returns toggle state of F4_bulb3_radio
button_state = get(hObject,'Value');
if button_state == get(hObject,'Max')
    set(handles.F4_bulb3_radio, 'Value', 1);
    set(handles.F4_bulb3_radio,'BackgroundColor','green');
    F4_bulb_3 = 7; % watt
elseif button_state == get(hObject,'Min')
    set(handles.F4_bulb3_radio, 'Value', 0);
    set(handles.F4_bulb3_radio,'BackgroundColor',[0.94 0.94 0.94]);
    F4_bulb_3 = 0; % watt
end
set_param('House_model/Floor_4/Lightening/F4_bulb_3','Value', num2str(F4_bulb_3));

% --- Executes on button press in F4_bulb4_radio.
function F4_bulb4_radio_Callback(hObject, eventdata, handles)
% hObject    handle to F4_bulb4_radio (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hint: get(hObject,'Value') returns toggle state of F4_bulb4_radio
button_state = get(hObject,'Value');
if button_state == get(hObject,'Max')
    set(handles.F4_bulb4_radio, 'Value', 1);
    set(handles.F4_bulb4_radio,'BackgroundColor','green');
    F4_bulb_4 = 7; % watt
elseif button_state == get(hObject,'Min')
    set(handles.F4_bulb4_radio, 'Value', 0);
    set(handles.F4_bulb4_radio,'BackgroundColor',[0.94 0.94 0.94]);
    F4_bulb_4 = 0; % watt
end
set_param('House_model/Floor_4/Lightening/F4_bulb_4','Value', num2str(F4_bulb_4));

% --- Executes on button press in F4_bulb1_radio.
function F4_bulb5_radio_Callback(hObject, eventdata, handles)
% hObject    handle to F4_bulb1_radio (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hint: get(hObject,'Value') returns toggle state of F4_bulb1_radio
button_state = get(hObject,'Value');
if button_state == get(hObject,'Max')
    set(handles.F4_bulb5_radio, 'Value', 1);
    set(handles.F4_bulb5_radio,'BackgroundColor','green');
    F4_bulb_5 = 7; % watt
elseif button_state == get(hObject,'Min')
    set(handles.F4_bulb5_radio, 'Value', 0);
    set(handles.F4_bulb5_radio,'BackgroundColor',[0.94 0.94 0.94]);
    F4_bulb_5 = 0; % watt
end
set_param('House_model/Floor_4/Lightening/F4_bulb_5','Value', num2str(F4_bulb_5));

% --- Executes on button press in F4_bulb6_radio.
function F4_bulb6_radio_Callback(hObject, eventdata, handles)
% hObject    handle to F4_bulb6_radio (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hint: get(hObject,'Value') returns toggle state of F4_bulb6_radio
button_state = get(hObject,'Value');
if button_state == get(hObject,'Max')
    set(handles.F4_bulb6_radio, 'Value', 1);
    set(handles.F4_bulb6_radio,'BackgroundColor','green');
    F4_bulb_6 = 7; % watt
elseif button_state == get(hObject,'Min')
    set(handles.F4_bulb6_radio, 'Value', 0);
    set(handles.F4_bulb6_radio,'BackgroundColor',[0.94 0.94 0.94]);
    F4_bulb_6 = 0; % watt
end
set_param('House_model/Floor_4/Lightening/F4_bulb_6','Value', num2str(F4_bulb_6));

% --- Executes on button press in F4_bulb7_radio.
function F4_bulb7_radio_Callback(hObject, eventdata, handles)
% hObject    handle to F4_bulb7_radio (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hint: get(hObject,'Value') returns toggle state of F4_bulb7_radio
button_state = get(hObject,'Value');
if button_state == get(hObject,'Max')
    set(handles.F4_bulb7_radio, 'Value', 1);
    set(handles.F4_bulb7_radio,'BackgroundColor','green');
    F4_bulb_7 = 7; % watt
elseif button_state == get(hObject,'Min')
    set(handles.F4_bulb7_radio, 'Value', 0);
    set(handles.F4_bulb7_radio,'BackgroundColor',[0.94 0.94 0.94]);
    F4_bulb_7 = 0; % watt
end
set_param('House_model/Floor_4/Lightening/F4_bulb_7','Value', num2str(F4_bulb_7));

% --- Executes on button press in F4_bulb8_radio.
function F4_bulb8_radio_Callback(hObject, eventdata, handles)
% hObject    handle to F4_bulb8_radio (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hint: get(hObject,'Value') returns toggle state of F4_bulb8_radio
button_state = get(hObject,'Value');
if button_state == get(hObject,'Max')
    set(handles.F4_bulb8_radio, 'Value', 1);
    set(handles.F4_bulb8_radio,'BackgroundColor','green');
    F4_bulb_8 = 7; % watt
elseif button_state == get(hObject,'Min')
    set(handles.F4_bulb8_radio, 'Value', 0);
    set(handles.F4_bulb8_radio,'BackgroundColor',[0.94 0.94 0.94]);
    F4_bulb_8 = 0; % watt
end
set_param('House_model/Floor_4/Lightening/F4_bulb_8','Value', num2str(F4_bulb_8));

%%% FLOURECENTS
% --- Executes on button press in F4_flourecent1_toggle.
function F4_flourecent1_toggle_Callback(hObject, eventdata, handles)
% hObject    handle to F4_flourecent1_toggle (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
button_state = get(hObject,'Value');
if button_state == get(hObject,'Max')
    set(handles.F4_flourecent1_toggle, 'Value', 1);
    set(handles.F4_flourecent1_toggle,'BackgroundColor','green');
    F4_flourecent_1 = 36; % watt
elseif button_state == get(hObject,'Min')
    set(handles.F4_flourecent1_toggle, 'Value', 0);
    set(handles.F4_flourecent1_toggle,'BackgroundColor',[0.94 0.94 0.94]);
    F4_flourecent_1 = 0; % watt
end
set_param('House_model/Floor_4/Lightening/F4_flourecent_1','Value', num2str(F4_flourecent_1));

% --- Executes on button press in F4_flourecent2_toggle.
function F4_flourecent2_toggle_Callback(hObject, eventdata, handles)
% hObject    handle to F4_flourecent2_toggle (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
button_state = get(hObject,'Value');
if button_state == get(hObject,'Max')
    set(handles.F4_flourecent2_toggle, 'Value', 1);
    set(handles.F4_flourecent2_toggle,'BackgroundColor','green');
    F4_flourecent_2 = 36; % watt
elseif button_state == get(hObject,'Min')
    set(handles.F4_flourecent2_toggle, 'Value', 0);
    set(handles.F4_flourecent2_toggle,'BackgroundColor',[0.94 0.94 0.94]);
    F4_flourecent_2 = 0; % watt
end
set_param('House_model/Floor_4/Lightening/F4_flourecent_2','Value', num2str(F4_flourecent_2));
     
% --- Executes on button press in F4_flourecent3_toggle.
function F4_flourecent3_toggle_Callback(hObject, eventdata, handles)
% hObject    handle to F4_flourecent3_toggle (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%wn=2;
%sys = tf(wn^2,[1,2*wn,wn^2]);
%sys = wn^2;
button_state = get(hObject,'Value');
if button_state == get(hObject,'Max')
    set(handles.F4_flourecent3_toggle, 'Value', 1);
    set(handles.F4_flourecent3_toggle,'BackgroundColor','green');
    F4_flourecent_3 = 36; % watt
elseif button_state == get(hObject,'Min')
    set(handles.F4_flourecent3_toggle, 'Value', 0);
    set(handles.F4_flourecent3_toggle,'BackgroundColor',[0.94 0.94 0.94]);
    F4_flourecent_3 = 0; % watt
end
set_param('House_model/Floor_4/Lightening/F4_flourecent_3','Value', num2str(F4_flourecent_3));
%plot(ScopeData.time,ScopeData.signals.values)
% f = figure;
% ax = axes('Parent',f,'position',[0.13 0.39  0.77 0.54]);
% h = plot(ax,sys);
% setoptions(h,'XLim',[0,10],'YLim',[0,2]);
%b.Callback = @(es,ed) updateSystem(h,wn^2*2*(es.Value)*wn);
% zeta = .5;                           % Damping Ratio
% wn = 2;                              % Natural Frequency
% sys = tf(wn^2,[1,2*zeta*wn,wn^2]);
% f = figure;
% ax = axes('Parent',f,'position',[0.13 0.39  0.77 0.54]);
% h = stepplot(ax,sys);
%
% setoptions(h,'XLim',[0,10],'YLim',[0,2]);
%b = uicontrol('Parent',f,'Style','slider','Position',[81,54,419,23],...
%              'value',zeta, 'min',0, 'max',1);
%b.Callback = @(es,ed) updateSystem(h,tf(wn^2,[1,2*(es.Value)*wn,wn^2]));

% --- Executes on button press in F4_flourecent4_toggle.
function F4_flourecent4_toggle_Callback(hObject, eventdata, handles)
% hObject    handle to F4_flourecent4_toggle (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hint: get(hObject,'Value') returns toggle state of togglebutton1
button_state = get(hObject,'Value');
if button_state == get(hObject,'Max')
    set(handles.F4_flourecent4_toggle, 'Value', 1);
    set(handles.F4_flourecent4_toggle,'BackgroundColor','green');
    F4_flourecent_4 = 36; % watt
elseif button_state == get(hObject,'Min')
    set(handles.F4_flourecent4_toggle, 'Value', 0);
    set(handles.F4_flourecent4_toggle,'BackgroundColor',[0.94 0.94 0.94]);
    F4_flourecent_4 = 0; % watt
end
set_param('House_model/Floor_4/Lightening/F4_flourecent_4','Value', num2str(F4_flourecent_4));

% --- Executes on button press in F4_flourecent5_toggle.
function F4_flourecent5_toggle_Callback(hObject, eventdata, handles)
% hObject    handle to F4_flourecent5_toggle (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
button_state = get(hObject,'Value');
if button_state == get(hObject,'Max')
    set(handles.F4_flourecent5_toggle, 'Value', 1);
    set(handles.F4_flourecent5_toggle,'BackgroundColor','green');
    F4_flourecent_5 = 36; % watt
elseif button_state == get(hObject,'Min')
    set(handles.F4_flourecent5_toggle, 'Value', 0);
    set(handles.F4_flourecent5_toggle,'BackgroundColor',[0.94 0.94 0.94]);
    F4_flourecent_5 = 0; % watt
end
set_param('House_model/Floor_4/Lightening/F4_flourecent_5','Value', num2str(F4_flourecent_5));

% --- Executes on button press in F4_flourecent6_toggle.
function F4_flourecent6_toggle_Callback(hObject, eventdata, handles)
% hObject    handle to F4_flourecent6_toggle (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
button_state = get(hObject,'Value');
if button_state == get(hObject,'Max')
    set(handles.F4_flourecent6_toggle, 'Value', 1);
    set(handles.F4_flourecent6_toggle,'BackgroundColor','green');
    F4_flourecent_6 = 36; % watt
elseif button_state == get(hObject,'Min')
    set(handles.F4_flourecent6_toggle, 'Value', 0);
    set(handles.F4_flourecent6_toggle,'BackgroundColor',[0.94 0.94 0.94]);
    F4_flourecent_6 = 0; % watt
end
set_param('House_model/Floor_4/Lightening/F4_flourecent_6','Value', num2str(F4_flourecent_6));

% --- Executes on button press in F4_maxeffect_toggle.
function F4_maxeffect_toggle_Callback(hObject, eventdata, handles)
% hObject    handle to F4_maxeffect_toggle (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Bulbs
F4_bulb1_radio_Callback(hObject, eventdata, handles);
F4_bulb2_radio_Callback(hObject, eventdata, handles);
F4_bulb3_radio_Callback(hObject, eventdata, handles);
F4_bulb4_radio_Callback(hObject, eventdata, handles);
F4_bulb5_radio_Callback(hObject, eventdata, handles);
F4_bulb6_radio_Callback(hObject, eventdata, handles);
F4_bulb7_radio_Callback(hObject, eventdata, handles);
F4_bulb8_radio_Callback(hObject, eventdata, handles);
% Flourecents
F4_flourecent1_toggle_Callback(hObject, eventdata, handles);
F4_flourecent2_toggle_Callback(hObject, eventdata, handles);
F4_flourecent3_toggle_Callback(hObject, eventdata, handles);
F4_flourecent4_toggle_Callback(hObject, eventdata, handles);
F4_flourecent5_toggle_Callback(hObject, eventdata, handles);
F4_flourecent6_toggle_Callback(hObject, eventdata, handles);
% Other electricity
F4_accesspoint1_radio_Callback(hObject, eventdata, handles);


%%% OTHER ELECTRICITY

% --- Executes on button press in F4_accesspoint1_radio.
function F4_accesspoint1_radio_Callback(hObject, eventdata, handles)
% hObject    handle to F4_accesspoint1_radio (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hint: get(hObject,'Value') returns toggle state of F4_accesspoint1_radio
button_state = get(hObject,'Value');
if button_state == get(hObject,'Max')
    set(handles.F4_accesspoint1_radio, 'Value', 1);
    set(handles.F4_accesspoint1_radio,'BackgroundColor','green');
    F4_accesspoint_1 = 6.5; % watt
elseif button_state == get(hObject,'Min')
    set(handles.F4_accesspoint1_radio, 'Value', 0);
    set(handles.F4_accesspoint1_radio,'BackgroundColor',[0.94 0.94 0.94]);
    F4_accesspoint_1 = 0; % watt
end
set_param('House_model/Floor_4/Other/F4_accesspoint_1','Value', num2str(F4_accesspoint_1));


%-----------------------------------------------------------------------
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%           Plot
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% --- Executes during object creation, after setting all properties.
function axes4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to axes4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
% Hint: place code in OpeningFcn to populate axes4
%rto = get_param(gcb,'RuntimeObject');
%blk = 'House_model/F4_bulb';
%event = 'PostOutputs';
%listener = 
%h = add_exec_event_listener(blk,event,listener)
%BlockTypes = get_param(BlockPaths,'BlockType')
%BlockTypes = get_param(House_model/F4_bulb,'Scope')
%rto = get_param(gcb,'simout');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


