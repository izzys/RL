function varargout = RLgui(varargin)
% RLGUI MATLAB code for RLgui.fig
%      RLGUI, by itself, creates a new RLGUI or raises the existing
%      singleton*.
%
%      H = RLGUI returns the handle to a new RLGUI or the handle to
%      the existing singleton*.
%
%      RLGUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in RLGUI.M with the given input arguments.
%
%      RLGUI('Property','Value',...) creates a new RLGUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before RLgui_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to RLgui_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help RLgui

% Last Modified by GUIDE v2.5 12-Nov-2015 19:07:48

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @RLgui_OpeningFcn, ...
                   'gui_OutputFcn',  @RLgui_OutputFcn, ...
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


% --- Executes just before RLgui is made visible.
function RLgui_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to RLgui (see VARARGIN)

% Choose default command line output for RLgui
handles.output = hObject;


% UIWAIT makes RLgui wait for user response (see UIRESUME)
 %uiwait(handles.figure1);
 
 % create RL agent:c
% global RL
% RL = ReinforcementLearning([],[]);
handles.RL = ReinforcementLearning([],[]);

% Update handles structure
guidata(hObject, handles)

% --- Outputs from this function are returned to the command line.
function varargout = RLgui_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on slider movement.
function slider_gamma_Callback(hObject, eventdata, handles)
% hObject    handle to slider gamma (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
%global RL


gamma = get(hObject,'Value');
handles = guihandles;
gamma_handle = handles.edit1;
set(gamma_handle,'String',gamma)


% --- Executes during object creation, after setting all properties.
function slider_gamma_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider gamma (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


function edit_gamma_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double
%global RL



gamma = get(hObject,'String');
gamma = str2double(gamma);
handles = guihandles;
gamma_handle = handles.slider3;
max_val  = get(gamma_handle,'Max');
min_val  = get(gamma_handle,'Min');
gamma = min(max_val,max(min_val,gamma));
set(hObject,'String',gamma)
set(gamma_handle,'Value',gamma)

% --- Executes during object creation, after setting all properties.
function edit_gamma_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on slider movement.
function slider_alpha_Callback(hObject, eventdata, handles)
% hObject    handle to slider alpha (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


alpha = get(hObject,'Value');
alpha_handle = handles.edit2;
set(alpha_handle,'String',alpha)



% --- Executes during object creation, after setting all properties.
function slider_alpha_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider alpha (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

function edit_alpha_Callback(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit2 as text
%        str2double(get(hObject,'String')) returns contents of edit2 as a double
%global RL


alpha = get(hObject,'String');
alpha = str2double(alpha);
alpha_handle = handles.slider4;
max_val  = get(alpha_handle,'Max');
min_val  = get(alpha_handle,'Min');
alpha = min(max_val,max(min_val,alpha));
set(hObject,'String',alpha)
set(alpha_handle,'Value',alpha)

% --- Executes during object creation, after setting all properties.
function edit_alpha_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on slider movement.
function slider_eps_Callback(hObject, eventdata, handles)

% hObject    handle to slider6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
%global RL

eps = get(hObject,'Value');
eps_handle = handles.edit6;
set(eps_handle,'String',eps)

HandleEpsCB(handles.RL,hObject);

% --- Executes during object creation, after setting all properties.
function slider_eps_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


function edit_epsilon_Callback(hObject, eventdata, handles)
% hObject    handle to edit6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hints: get(hObject,'String') returns contents of edit6 as text
%        str2double(get(hObject,'String')) returns contents of edit6 as a double
global RL

eps = get(hObject,'String');
eps = str2double(eps);
eps_handle = handles.slider6;
max_val  = get(eps_handle,'Max');
min_val  = get(eps_handle,'Min');
eps = min(max_val,max(min_val,eps));
set(hObject,'String',eps)
set(eps_handle,'Value',eps)

%RL.HandleEpsCallback(eps);

% --- Executes during object creation, after setting all properties.
function edit_epsilon_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on selection change in popupmenu1.
function popupmenu_model_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu1
global RL

contents = cellstr(get(hObject,'String')) ;
selected_model = contents{get(hObject,'Value')};
text_handle = handles.text9;
push_handle = handles.pushbutton3;
method_handle = handles.popupmenu2;



if ~strcmp(selected_model,'select model')
   set(text_handle,'Visible','off')
   set(push_handle,'Enable','on')
   
   popupmenu_method_Callback(method_handle, [], handles)
   
else
   set(text_handle,'Visible','on')
   set(push_handle,'Enable','off')
   
   popupmenu_method_Callback(method_handle, [], handles)
end

% --- Executes during object creation, after setting all properties.
function popupmenu_model_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on selection change in popupmenu2.
function popupmenu_method_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu method (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu2 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu2
global RL

contents = cellstr(get(hObject,'String')) ;
selected_method = contents{get(hObject,'Value')};
text_handle = handles.text10;
push_handle = handles.pushbutton2;
model_handle = handles.popupmenu1;
models = cellstr(get(model_handle,'String')) ;
selected_model = models{get(model_handle,'Value')};


if ~strcmp(selected_method,'select method')
   set(text_handle,'Visible','off')
   
   if ~strcmp(selected_model,'select model')
      set(push_handle,'Enable','on')
   else
      set(push_handle,'Enable','inactive') 
   end
       
else
   set(text_handle,'Visible','on')
   set(push_handle,'Enable','off')
end

% --- Executes during object creation, after setting all properties.
function popupmenu_method_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu method (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global RL

run_episode_handle = handles.pushbutton3;
graphics_handle = handles.radiobutton1;
model_handle = handles.popupmenu1;
method_handle = handles.popupmenu2;


on = get(hObject,'UserData');
if ~on
    set(hObject,'String','Stop learning')
    set(hObject,'BackgroundColor',[1 0.6 0.6])
    set(run_episode_handle,'Enable','off')
    set(graphics_handle,'Enable','on')
    set(model_handle,'Enable','off')
    set(method_handle,'Enable','off')
else
    set(hObject,'String','Start learning')
    set(hObject,'BackgroundColor',[0.6 0.8 0.5])
    set(run_episode_handle,'Enable','on')
    set(graphics_handle,'Enable','off')
    set(model_handle,'Enable','on')
    set(method_handle,'Enable','on')
end
on = ~on;
set(hObject,'UserData',on);

% --- Executes on button press in checkbox2.
function checkbox2_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox2
global RL

val = get(hObject,'Value');
edit_handle = handles.edit5; 
if val 
  set(edit_handle,'Enable','on')  
else
  set(edit_handle,'Enable','off')      
end

function edit5_Callback(hObject, eventdata, handles)
% hObject    handle to edit5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit5 as text
%        str2double(get(hObject,'String')) returns contents of edit5 as a double
global RL

val = get(hObject,'String');
val = str2double(val);
max_val  = get(hObject,'Max');
min_val  = get(hObject,'Min');
val = min(max_val,max(min_val,val));
set(hObject,'String',val)

% --- Executes during object creation, after setting all properties.
function edit5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on button press in checkbox3.
function checkbox3_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox3
global RL

% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

disp('make sure to disable until episode is done')
global RL

function edit7_Callback(hObject, eventdata, handles)
% hObject    handle to edit7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit7 as text
%        str2double(get(hObject,'String')) returns contents of edit7 as a double
global RL

val = get(hObject,'String');
val = str2double(val);
max_val  = get(hObject,'Max');
min_val  = get(hObject,'Min');
val = min(max_val,max(min_val,val));
set(hObject,'String',val)

% --- Executes during object creation, after setting all properties.
function edit7_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in checkbox4.
function checkbox4_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox4
global RL

val = get(hObject,'Value');
edit_handle = handles.edit7; 
if val 
  set(edit_handle,'Enable','on')  
else
  set(edit_handle,'Enable','off')      
end


% --- Executes during object creation, after setting all properties.
function axes2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to axes2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate axes2


% --- If Enable == 'on', executes on mouse press in 5 pixel border.
% --- Otherwise, executes on mouse press in 5 pixel border or over pushbutton2.
function pushbutton2_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in radiobutton1.
function radiobutton1_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton1
global RL

% --- Executes during object creation, after setting all properties.
function uipanel1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to uipanel1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --------------------------------------------------------------------
function about_Callback(hObject, eventdata, handles)
% hObject    handle to about (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles = guihandles;
about_handle = handles.uipanel10; 
close_handle = handles.pushbutton7;
text_handle = handles.text13;
set(about_handle,'Visible','on')
set(close_handle,'Visible','on')
set(text_handle,'Visible','on')


% --- Executes on button press in pushbutton7.
function pushbutton7_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles = guihandles;
about_handle = handles.uipanel10; 
close_handle = handles.pushbutton7;
text_handle = handles.text13; 
set(about_handle,'Visible','off')
set(close_handle,'Visible','on')
set(text_handle,'Visible','off')

% --- If Enable == 'on', executes on mouse press in 5 pixel border.
% --- Otherwise, executes on mouse press in 5 pixel border or over pushbutton7.
function pushbutton7_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to pushbutton7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in checkbox5.
function checkbox5_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox5
val = get(hObject,'Value');
handles = guihandles;
help_handle = handles.uipanel11; 
text_handle = handles.text11;
if val
set(help_handle,'Visible','on')
set(text_handle,'Visible','on')
else
set(help_handle,'Visible','off')
set(text_handle,'Visible','off')
end
% --- If Enable == 'on', executes on mouse press in 5 pixel border.
% --- Otherwise, executes on mouse press in 5 pixel border or over checkbox5.
function checkbox5_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to checkbox5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes during object deletion, before destroying properties.
function figure1_DeleteFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes when user attempts to close figure1.
function figure1_CloseRequestFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: delete(hObject) closes the figure
delete(hObject);



function edit8_Callback(hObject, eventdata, handles)
% hObject    handle to edit8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit8 as text
%        str2double(get(hObject,'String')) returns contents of edit8 as a double


% --- Executes during object creation, after setting all properties.
function edit8_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
