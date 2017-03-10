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
FigWidth = 1;%0.265;

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

% bulb max 7 Watt
% energy/day 0.28 kW         

% --- Executes on button press in F4_readbulb.
function F4_readbulb_Callback(hObject, eventdata, handles)
% hObject    handle to F4_readbulb (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%wn=2;
%sys = tf(wn^2,[1,2*wn,wn^2]); 
%sys = wn^2; 

%button_state = get(hObject,'Value');

%if button_state == get(hObject,'Max')
%else button_state == get(hObject,'Min')
%    set(handles.F4_readbulb,'BackgroundColor','red');
%    F4_bulb = 0; % watt
%end
    set(handles.F4_readbulb,'BackgroundColor','green');
    F4_bulb = 7; % watt

    set_param('House_model/F4_bulb','Value', num2str(F4_bulb));





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


% --- Executes on button press in pushbutton6.
function pushbutton6_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton7.
function pushbutton7_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton8.
function pushbutton8_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton9.
function pushbutton9_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton10.
function pushbutton10_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in radiobutton9.
function radiobutton9_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton9

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





% --- Executes on button press in pushbutton23.
function pushbutton23_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton23 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

