function varargout = Diffusion(varargin)
% DIFFUSION MATLAB code for Diffusion.fig
%      DIFFUSION, by itself, creates a new DIFFUSION or raises the existing
%      singleton*.
%
%      H = DIFFUSION returns the handle to a new DIFFUSION or the handle to
%      the existing singleton*.
%
%      DIFFUSION('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in DIFFUSION.M with the given input arguments.
%
%      DIFFUSION('Property','Value',...) creates a new DIFFUSION or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Diffusion_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Diffusion_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Diffusion

% Last Modified by GUIDE v2.5 12-Mar-2017 21:50:37

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Diffusion_OpeningFcn, ...
                   'gui_OutputFcn',  @Diffusion_OutputFcn, ...
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


% --- Executes just before Diffusion is made visible.
function Diffusion_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Diffusion (see VARARGIN)

% Choose default command line output for Diffusion
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

set(handles.Surface_Concentration_1, 'string', 1e15)
set(handles.Constant_Source_1, 'value', 1)
set(handles.Temp_1, 'string', 1200)
set(handles.Time_1, 'string', 60)
set(handles.Depth_1, 'string', 1)
set(handles.hours, 'string', 0)
movegui(gcf,'center')

% UIWAIT makes Diffusion wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Diffusion_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function Depth_1_Callback(hObject, eventdata, handles)
% hObject    handle to Depth_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
segmentlen = str2double(get(hObject,'string'));
if isnan(segmentlen) || (segmentlen < 0)
    segmentlen = 1;
    errordlg('Input a value for the diffusion time','Error');
    set(hObject,'String',num2str(segmentlen));
end
% Hints: get(hObject,'String') returns contents of Depth_1 as text
%        str2double(get(hObject,'String')) returns contents of Depth_1 as a double


% --- Executes during object creation, after setting all properties.
function Depth_1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Depth_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



% --- Executes on button press in Constant_Source_1.
function Constant_Source_1_Callback(hObject, eventdata, handles)
% hObject    handle to Constant_Source_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
check_2 = get(handles.Constant_Source_1, 'value');
if check_2 == 1
    set(handles.Source_Drive_in_1, 'value', 0)
end
% Hint: get(hObject,'Value') returns toggle state of Constant_Source_1



function Time_1_Callback(hObject, eventdata, handles)
% hObject    handle to Time_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
segmentlen = str2double(get(hObject,'string'));
if isnan(segmentlen) || (segmentlen < 0)
    segmentlen = 60;
    errordlg('Input a value for the diffusion time','Error');
    set(hObject,'String',num2str(segmentlen));
end
% Hints: get(hObject,'String') returns contents of Time_1 as text
%        str2double(get(hObject,'String')) returns contents of Time_1 as a double


% --- Executes during object creation, after setting all properties.
function Time_1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Time_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in Solve.
function Solve_Callback(hObject, eventdata, handles)
% hObject    handle to Solve (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

Delta_x = 1e-6;
Delta_t = 0.25;

Cs = str2num(get(handles.Surface_Concentration_1, 'string'));
T = str2num(get(handles.Temp_1, 'string'));
t = str2num(get(handles.Time_1, 'string'));
hrs = str2num(get(handles.hours, 'string'));
x = str2num(get(handles.Depth_1, 'string')); x = round(x);
Constant_Source = get(handles.Constant_Source_1, 'value');
Source_Drive_in = get(handles.Source_Drive_in_1, 'value');

T = T+273; 
t = (t*60);
hrs = (hrs*60*60);

t1 = (hrs+t)*Delta_t;
V_x = [0:Delta_x:(1000000)*Delta_x];
k = 1.38*10^-23;
Ea = (3.5)*(1.602*10^-19);
Do = 1;
D = Do * exp(-Ea/(k*T));
%D = 1e-12;

if Constant_Source == 1
    Concentration = Cs*erfc(V_x./(2*sqrt(D*t1)));
    C = Concentration(x);
    axes(handles.axes1); 
    %plot(Concentration, 'Linewidth', 1.5); grid on;
    semilogy(Concentration, 'Linewidth', 1.5); grid on;
    set(handles.Impurity_Concentration_1, 'string', C)
    xlabel('Diffusion depth x (um)', 'FontSize',10);
    ylabel('Concentration (cm^{-3})', 'FontSize',10);
    legend(['Diffusion Time = ' num2str((t/60)+(hrs/60)) ' minutes']);
    title({'limited source Boron diffusion (drive-in)'; ...
        ['at a temperature of ' num2str(T-273) '°C']},'FontSize',10);

elseif Source_Drive_in == 1
    Q = 2*Cs*sqrt(pi*D);
    Concentration = (Q/sqrt(pi*D*t1))*exp(-V_x.^2/(4*D*t1));
    C = Concentration(x);
    axes(handles.axes1);
    %plot(Concentration, 'Linewidth', 1.5); grid on;
    semilogy(Concentration, 'Linewidth', 1.5); grid on;
    set(handles.Impurity_Concentration_1, 'string', C)
    xlabel('Diffusion depth x (um)', 'FontSize',10);
    ylabel('Concentration (cm^{-3})', 'FontSize',10);
    legend(['Diffusion Time = ' num2str((t/60)/(hrs/60)) ' minutes']);
    title({'Constant source Boron diffusion'; ...
        ['at a temperature of ' num2str(T-273) '°C']},'FontSize',10);
end


function Surface_Concentration_1_Callback(hObject, eventdata, handles)
% hObject    handle to Surface_Concentration_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
segmentlen = str2double(get(hObject,'string'));
if isnan(segmentlen) || (segmentlen < 0)
    segmentlen = 1e15;
    errordlg('Input a value for Surface Concentration','Error');
    set(hObject,'String',num2str(segmentlen));
end
% Hints: get(hObject,'String') returns contents of Surface_Concentration_1 as text
%        str2double(get(hObject,'String')) returns contents of Surface_Concentration_1 as a double


% --- Executes during object creation, after setting all properties.
function Surface_Concentration_1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Surface_Concentration_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in Source_Drive_in_1.
function Source_Drive_in_1_Callback(hObject, eventdata, handles)
% hObject    handle to Source_Drive_in_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
check_1 = get(handles.Source_Drive_in_1, 'value');
if check_1 == 1
    set(handles.Constant_Source_1, 'value', 0)
end
% Hint: get(hObject,'Value') returns toggle state of Source_Drive_in_1



function Temp_1_Callback(hObject, eventdata, handles)
% hObject    handle to Temp_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
segmentlen = str2double(get(hObject,'string'));
if isnan(segmentlen) || (segmentlen < 0)
    segmentlen = 1200;
    errordlg('Input a value for the Temperature','Error');
    set(hObject,'String',num2str(segmentlen));
end
% Hints: get(hObject,'String') returns contents of Temp_1 as text
%        str2double(get(hObject,'String')) returns contents of Temp_1 as a double


% --- Executes during object creation, after setting all properties.
function Temp_1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Temp_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in microns_1.
function microns_1_Callback(hObject, eventdata, handles)
% hObject    handle to microns_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
check_3 = get(handles.microns_1, 'value');
if check_3 == 1
    set(handles.cm_1, 'value', 0)
end
% Hint: get(hObject,'Value') returns toggle state of microns_1


% --- Executes on button press in cm_1.
function cm_1_Callback(hObject, eventdata, handles)
% hObject    handle to cm_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
check_4 = get(handles.cm_1, 'value');
if check_4 == 1
    set(handles.microns_1, 'value', 0)
end
% Hint: get(hObject,'Value') returns toggle state of cm_1


% --- Executes on button press in sec_1.
function sec_1_Callback(hObject, eventdata, handles)
% hObject    handle to sec_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
check_5 = get(handles.sec_1, 'value');
if check_5 == 1
    set(handles.min_1, 'value', 0)
end
% Hint: get(hObject,'Value') returns toggle state of sec_1


% --- Executes on button press in min_1.
function min_1_Callback(hObject, eventdata, handles)
% hObject    handle to min_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
check_6 = get(handles.min_1, 'value');
if check_6 == 1
    set(handles.sec_1, 'value', 0)
end
% Hint: get(hObject,'Value') returns toggle state of min_1


% --- Executes on button press in Home.
function Home_Callback(hObject, eventdata, handles)
% hObject    handle to Home (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
close(Diffusion);
Main_GUI;


% --- Executes on button press in Diffusion_2.
function Diffusion_2_Callback(hObject, eventdata, handles)
% hObject    handle to Diffusion_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
close(Diffusion);
Gaussian_Diffusion;



function hours_Callback(hObject, eventdata, handles)
% hObject    handle to hours (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
segmentlen = str2double(get(hObject,'string'));
if isnan(segmentlen) || (segmentlen < 0)
    segmentlen = 0;
    errordlg('Input a value for the diffusion time','Error');
    set(hObject,'String',num2str(segmentlen));
end
% Hints: get(hObject,'String') returns contents of hours as text
%        str2double(get(hObject,'String')) returns contents of hours as a double


% --- Executes during object creation, after setting all properties.
function hours_CreateFcn(hObject, eventdata, handles)
% hObject    handle to hours (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
