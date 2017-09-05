function varargout = Gaussian_Diffusion(varargin)
% GAUSSIAN_DIFFUSION MATLAB code for Gaussian_Diffusion.fig
%      GAUSSIAN_DIFFUSION, by itself, creates a new GAUSSIAN_DIFFUSION or raises the existing
%      singleton*.
%
%      H = GAUSSIAN_DIFFUSION returns the handle to a new GAUSSIAN_DIFFUSION or the handle to
%      the existing singleton*.
%
%      GAUSSIAN_DIFFUSION('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GAUSSIAN_DIFFUSION.M with the given input arguments.
%
%      GAUSSIAN_DIFFUSION('Property','Value',...) creates a new GAUSSIAN_DIFFUSION or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Gaussian_Diffusion_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Gaussian_Diffusion_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Gaussian_Diffusion

% Last Modified by GUIDE v2.5 12-Mar-2017 21:45:47

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Gaussian_Diffusion_OpeningFcn, ...
                   'gui_OutputFcn',  @Gaussian_Diffusion_OutputFcn, ...
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


% --- Executes just before Gaussian_Diffusion is made visible.
function Gaussian_Diffusion_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Gaussian_Diffusion (see VARARGIN)

% Choose default command line output for Gaussian_Diffusion
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);
movegui(gcf,'center')
set(handles.Boundary_2, 'value', 1)
set(handles.C_Initial, 'string', 1e15)
set(handles.time, 'string', 100)
set(handles.hour, 'string', 0)
Cs = 1e15;
D = 1e-12;

Delta_x = 1e-6;
Delta_t = 0.25;

user_x = 1;
x = [0:Delta_x:(user_x+10000)*Delta_x];

user_t = 1*60;
t = user_t*Delta_t;

Q = 2*Cs*sqrt(pi*D);
C_an = (Q/sqrt(pi*D*t))*exp(-x.^2/(4*D*t));

for i = 1:length(C_an)
    if C_an(i) > 0
        C1(i) = C_an(i);
    end
end

C2 = flip(C1);
C = [C2 C1];
fix_bins = [-1*length(C1) : length(C1)-1];
axes(handles.axes1);
plot(fix_bins, C, 'Linewidth', 2); grid on;
title({'limited source Baron diffusion (drive-in)'; ...
 'at a temperature of 1200°C'},'FontSize',14);
xlabel('Diffusion depth x (um)', 'FontSize',14);
ylabel('Concentration (cm^{-3})', 'FontSize',14);
legend(['Diffusion Time = 1 minutes']);
xlim([-400 400])
ylim([0 6e14])

% UIWAIT makes Gaussian_Diffusion wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Gaussian_Diffusion_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on slider movement.
function slider1_Callback(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
time = str2num(get(handles.time, 'string'));
hour = str2num(get(handles.hour, 'string'));
if hour == 0
    time = time;
elseif hour > 0 && time == 0
    hour = hour * 60;
    time = hour
elseif hour > 0 && time > 0
    hour = hour * 60;
    time = hour + time;
end
set(handles.slider1, 'Max', time, 'SliderStep', [0.1 0.2]);
Constant = get(handles.Boundary_1, 'value');
Drive_in = get(handles.Boundary_2, 'value');
Cs = str2num(get(handles.C_Initial, 'string'));
t = get(hObject,'Value');
if t == 0
    t = 1;
end
D = 1e-12;
Delta_x = 1e-6;
Delta_t = 0.25;
user_x = 1;
x = [0:Delta_x:(user_x+10000)*Delta_x];
user_t = t*60;
t1 = user_t*Delta_t;

if Drive_in == 1
    Q = 2*Cs*sqrt(pi*D);
    C_an = (Q/sqrt(pi*D*t1))*exp(-x.^2/(4*D*t1));
elseif Constant == 1
    C_an = Cs*erfc(x./(2*sqrt(D*t1)));
end

for i = 1:length(C_an)
    if C_an(i) > 0
        C1(i) = C_an(i);
    end
end
C2 = flip(C1);
C = [C2 C1];
fix_bins = [-1*length(C1) : length(C1)-1];
axes(handles.axes1); 
plot(fix_bins, C, 'Linewidth', 2); grid on;
xlabel('Diffusion depth x (um)', 'FontSize',14);
ylabel('Concentration (cm^{-3})', 'FontSize',14);
legend(['Diffusion Time = ' num2str(t) ' minutes']);
if Drive_in == 1
    title({'limited source Baron diffusion (drive-in)'; ...
        'at a temperature of 1200 Â°C'},'FontSize',14);
    xlim([-400 400])
    ylim([0 6e14])
elseif Constant == 1
    title({'Constant source Baron diffusion (drive-in)'; ...
        'at a temperature of 1200 Â°C'},'FontSize',14);
    xlim([-400 400])
    ylim([0 Cs])
end
guidata(hObject,handles);

% --- Executes during object creation, after setting all properties.
function slider1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end
set(hObject,'Max',100, 'SliderStep',[0.1 0.2]);
guidata(hObject,handles);
 
% --- Executes on button press in Boundary_1.
function Boundary_1_Callback(hObject, eventdata, handles)
% hObject    handle to Boundary_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of Boundary_1
check_1 = get(handles.Boundary_1, 'value');
if check_1 == 1
    set(handles.Boundary_2, 'value', 0)
end
set(handles.time, 'string', 100)
set(handles.hour, 'string', 0)
Cs = str2num(get(handles.C_Initial, 'string'));
t = get(hObject,'Value');
if t == 0
    t = 1;
end
D = 1e-12;
Delta_x = 1e-6;
Delta_t = 0.25;
user_x = 1;
x = [0:Delta_x:(user_x+10000)*Delta_x];
user_t = t*60;
t1 = user_t*Delta_t;
C_an = Cs*erfc(x./(2*sqrt(D*t1)));
for i = 1:length(C_an)
    if C_an(i) > 0
        C1(i) = C_an(i);
    end
end
C2 = flip(C1);
C = [C2 C1];
fix_bins = [-1*length(C1) : length(C1)-1];
axes(handles.axes1); 
plot(fix_bins, C, 'Linewidth', 2); grid on;
xlabel('Diffusion depth x (um)', 'FontSize',14);
ylabel('Concentration (cm^{-3})', 'FontSize',14);
legend(['Diffusion Time = ' num2str(t) ' minutes']);
title({'Constant source Baron diffusion'; ...
    'at a temperature of 1200°C'},'FontSize',14);
xlim([-400 400])
ylim([0 Cs])
guidata(hObject,handles);



% --- Executes on button press in Boundary_2.
function Boundary_2_Callback(hObject, eventdata, handles)
% hObject    handle to Boundary_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of Boundary_2
check_2 = get(handles.Boundary_2, 'value');
if check_2 == 1
    set(handles.Boundary_1, 'value', 0)
end
set(handles.time, 'string', 100)
set(handles.hour, 'string', 0)
Cs = str2num(get(handles.C_Initial, 'string'));
t = get(hObject,'Value');
if t == 0
    t = 1;
end
D = 1e-12;
Delta_x = 1e-6;
Delta_t = 0.25;
user_x = 1;
x = [0:Delta_x:(user_x+10000)*Delta_x];
user_t = t*60;
t1 = user_t*Delta_t;
Q = 2*Cs*sqrt(pi*D);
C_an = (Q/sqrt(pi*D*t1))*exp(-x.^2/(4*D*t1));
for i = 1:length(C_an)
    if C_an(i) > 0
        C1(i) = C_an(i);
    end
end
C2 = flip(C1);
C = [C2 C1];
fix_bins = [-1*length(C1) : length(C1)-1];
axes(handles.axes1); 
plot(fix_bins, C, 'Linewidth', 2); grid on;
xlabel('Diffusion depth x (um)', 'FontSize',14);
ylabel('Concentration (cm^{-3})', 'FontSize',14);
legend(['Diffusion Time = ' num2str(t) ' minutes']);
title({'limited source Baron diffusion (drive-in)'; ...
    'at a temperature of 1200°C'},'FontSize',14);
xlim([-400 400])
ylim([0 6e14])
guidata(hObject,handles);

function C_Initial_Callback(hObject, eventdata, handles)
% hObject    handle to C_Initial (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of C_Initial as text
%        str2double(get(hObject,'String')) returns contents of C_Initial as a double
segmentlen = str2double(get(hObject,'string'));
if isnan(segmentlen) || (segmentlen < 0)
    segmentlen = 1e15;
    errordlg('Input a time for the diffusion','Error');
    set(hObject,'String',num2str(segmentlen));
end

% --- Executes during object creation, after setting all properties.
function C_Initial_CreateFcn(hObject, eventdata, handles)
% hObject    handle to C_Initial (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function time_Callback(hObject, eventdata, handles)
% hObject    handle to time (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
segmentlen = str2double(get(hObject,'string'));
if isnan(segmentlen) || (segmentlen < 0)
    segmentlen = 100;
    errordlg('Input a time for the diffusion','Error');
    set(hObject,'String',num2str(segmentlen));
end

time = str2num(get(handles.time, 'string'));
set(handles.slider1, 'Max', time, 'SliderStep', [0.1 0.2]);
guidata(hObject,handles);
% Hints: get(hObject,'String') returns contents of time as text
%        str2double(get(hObject,'String')) returns contents of time as a double

% --- Executes during object creation, after setting all properties.
function time_CreateFcn(hObject, eventdata, handles)
% hObject    handle to time (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
guidata(hObject,handles);


function hour_Callback(hObject, eventdata, handles)
% hObject    handle to hour (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of hour as text
%        str2double(get(hObject,'String')) returns contents of hour as a double
segmentlen = str2double(get(hObject,'string'));
if isnan(segmentlen) || (segmentlen < 0)
    segmentlen = 0;
    errordlg('Input a time for the diffusion','Error');
    set(hObject,'String',num2str(segmentlen));
end

% --- Executes during object creation, after setting all properties.
function hour_CreateFcn(hObject, eventdata, handles)
% hObject    handle to hour (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in Home.
function Home_Callback(hObject, eventdata, handles)
% hObject    handle to Home (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
close(Gaussian_Diffusion);
Diffusion;
