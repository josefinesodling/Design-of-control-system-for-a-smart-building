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

%%%%%%%%%%%%%%%% FLOOR 4 %%%%%%%%%%%%%%%%%%%%%%%%
% bulb max 7 Watt, energy/day 0.28 kW total 
% flourecent max 36 Watt

% --- Executes on button press in radiobutton1_Lamp.
function radiobutton1_Lamp_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton1_Lamp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hint: get(hObject,'Value') returns toggle state of radiobutton1_Lamp


% --- Executes on button press in radiobutton2.
function radiobutton2_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hint: get(hObject,'Value') returns toggle state of radiobutton2


% --- Executes on button press in radiobutton3.
function radiobutton3_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hint: get(hObject,'Value') returns toggle state of radiobutton3


% --- Executes on button press in radiobutton4.
function radiobutton4_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hint: get(hObject,'Value') returns toggle state of radiobutton4


% --- Executes on button press in radiobutton5.
function radiobutton5_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hint: get(hObject,'Value') returns toggle state of radiobutton5


% --- Executes on button press in radiobutton6.
function radiobutton6_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hint: get(hObject,'Value') returns toggle state of radiobutton6


% --- Executes on button press in radiobutton7.
function radiobutton7_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hint: get(hObject,'Value') returns toggle state of radiobutton7


% --- Executes on button press in radiobutton8.
function radiobutton8_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hint: get(hObject,'Value') returns toggle state of radiobutton8


% --- Executes on button press in radiobutton9.
function radiobutton9_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hint: get(hObject,'Value') returns toggle state of radiobutton9



% --- Executes on button press in togglebutton1_F4.
function togglebutton1_F4_Callback(hObject, eventdata, handles)
% hObject    handle to togglebutton1_F4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
button_state = get(hObject,'Value');
if button_state == get(hObject,'Max')
    set(handles.togglebutton3_F4,'BackgroundColor','green');
    F4_flourecent_1 = 36; % watt
elseif button_state == get(hObject,'Min')
    set(handles.togglebutton3_F4,'BackgroundColor',[0.94 0.94 0.94]);
    F4_flourecent_1 = 0; % watt
end
set_param('House_model/Floor_4/Lightening/F4_flourecent_1','Value', num2str(F4_flourecent_1));

% --- Executes on button press in togglebutton2_F4.
function togglebutton2_F4_Callback(hObject, eventdata, handles)
% hObject    handle to togglebutton2_F4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
button_state = get(hObject,'Value');
if button_state == get(hObject,'Max')
    set(handles.togglebutton3_F4,'BackgroundColor','green');
    F4_flourecent_2 = 36; % watt
elseif button_state == get(hObject,'Min')
    set(handles.togglebutton3_F4,'BackgroundColor',[0.94 0.94 0.94]);
    F4_flourecent_2 = 0; % watt
end
set_param('House_model/Floor_4/Lightening/F4_flourecent_2','Value', num2str(F4_flourecent_2));
     
% --- Executes on button press in togglebutton3_F4.
function togglebutton3_F4_Callback(hObject, eventdata, handles)
% hObject    handle to togglebutton3_F4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%wn=2;
%sys = tf(wn^2,[1,2*wn,wn^2]);
%sys = wn^2;
button_state = get(hObject,'Value');
if button_state == get(hObject,'Max')
    set(handles.togglebutton3_F4,'BackgroundColor','green');
    F4_flourecent_3 = 36; % watt
elseif button_state == get(hObject,'Min')
    set(handles.togglebutton3_F4,'BackgroundColor',[0.94 0.94 0.94]);
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

% --- Executes on button press in togglebutton4_F4.
function togglebutton4_F4_Callback(hObject, eventdata, handles)
% hObject    handle to togglebutton4_F4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hint: get(hObject,'Value') returns toggle state of togglebutton1
button_state = get(hObject,'Value');
if button_state == get(hObject,'Max')
    set(handles.togglebutton4_F4,'BackgroundColor','green');
    F4_flourecent_4 = 36; % watt
elseif button_state == get(hObject,'Min')
    set(handles.togglebutton4_F4,'BackgroundColor',[0.94 0.94 0.94]);
    F4_flourecent_4 = 0; % watt
end
set_param('House_model/Floor_4/Lightening/F4_flourecent_4','Value', num2str(F4_flourecent_4));

% --- Executes on button press in togglebutton5_F4.
function togglebutton5_F4_Callback(hObject, eventdata, handles)
% hObject    handle to togglebutton5_F4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
button_state = get(hObject,'Value');
if button_state == get(hObject,'Max')
    set(handles.togglebutton3_F4,'BackgroundColor','green');
    F4_flourecent_5 = 7; % watt
elseif button_state == get(hObject,'Min')
    set(handles.togglebutton3_F4,'BackgroundColor',[0.94 0.94 0.94]);
    F4_flourecent_5 = 0; % watt
end
set_param('House_model/Floor_4/Lightening/F4_flourecent_5','Value', num2str(F4_flourecent_5));


% --- Executes on button press in togglebutton6_F4.
function togglebutton6_F4_Callback(hObject, eventdata, handles)
% hObject    handle to togglebutton6_F4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% --- Executes on button press in togglebutton7_F4.
function togglebutton7_F4_Callback(hObject, eventdata, handles)
% hObject    handle to togglebutton7_F4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



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



