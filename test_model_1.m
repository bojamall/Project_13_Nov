function varargout = test_model_1(varargin)

gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @test_model_1_OpeningFcn, ...
                   'gui_OutputFcn',  @test_model_1_OutputFcn, ...
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


function test_model_1_OpeningFcn(hObject, eventdata, handles, varargin)

handles.output = hObject;

guidata(hObject, handles);
set(handles.Pressure_2, 'enable', 'off')
set(handles.Silicon100, 'value', 1)
movegui(gcf,'center')
function varargout = test_model_1_OutputFcn(hObject, eventdata, handles) 

varargout{1} = handles.output;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%% axes_7 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function axes7_CreateFcn(hObject, eventdata, handles)

%%%%%%%%%%%%%%%%%%%%%%% set_initial_1 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function set_initial_1_Callback(hObject, eventdata, handles)

segmentlen = str2double(get(hObject,'string'));
if isnan(segmentlen) || (segmentlen < 10) || (segmentlen > 25)
    segmentlen = 0;
    errordlg('Input must be a number within the range','Error');
    set(hObject,'String',num2str(segmentlen));
end

function set_initial_1_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), ...
        get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%%%%%%%%%%%%%%%%%%%%%%% set_temperature_2 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function set_temperature_2_Callback(hObject, eventdata, handles)

segmentlen = str2double(get(hObject,'string'));
if isnan(segmentlen) || (segmentlen > 1200) || (segmentlen < 700)
    segmentlen = 0;
    errordlg('Input must be a number within the range','Error');
    set(hObject,'String',num2str(segmentlen));
end

function set_temperature_2_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), ...
        get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%%%%%%%%%%%%%%%%%%%%%%% set_total_growth %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function set_total_growth_Callback(hObject, eventdata, handles)

segmentlen = str2double(get(hObject,'string'));
if isnan(segmentlen)
    segmentlen = 0;
    errordlg('Input must be a number','Error');
    set(hObject,'String',num2str(segmentlen));
end

function set_total_growth_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), ...
        get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%%%%%%%%%%%%%%%%%%%%%%% set_total_growth_2 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function set_total_growth_2_Callback(hObject, eventdata, handles)

segmentlen = str2double(get(hObject,'string'));
if isnan(segmentlen)
    segmentlen = 0;
    errordlg('Input must be a number','Error');
    set(hObject,'String',num2str(segmentlen));
end

function set_total_growth_2_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), ...
        get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%%%%%%%%%%%%%%%%%%%%%%% Dry_O2_2_2 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function Dry_O2_2_Callback(hObject, eventdata, handles)

check_4 = get(handles.Dry_O2_2, 'value');
if check_4 == 1
    set(handles.H2O_2, 'value', 0)
    set(handles.wet_O2_2, 'value', 0)
end

%%%%%%%%%%%%%%%%%%%%%%% H2O_2 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function H2O_2_Callback(hObject, eventdata, handles)

check_5 = get(handles.H2O_2, 'value');
if check_5 == 1
    set(handles.Dry_O2_2, 'value', 0)
    set(handles.wet_O2_2, 'value', 0)
end

%%%%%%%%%%%%%%%%%%%%%%% wet_O2_2 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function wet_O2_2_Callback(hObject, eventdata, handles)

check_6 = get(handles.wet_O2_2, 'value');
if check_6 == 1
    set(handles.Dry_O2_2, 'value', 0)
    set(handles.H2O_2, 'value', 0)
end

% --- Executes on button press in Silicon111.
function Silicon111_Callback(hObject, eventdata, handles)

check_8 = get(handles.Silicon111, 'value');
if check_8 == 1
    set(handles.Silicon100, 'value', 0)
end

% --- Executes on button press in Silicon100.
function Silicon100_Callback(hObject, eventdata, handles)

check_7 = get(handles.Silicon100, 'value');
if check_7 == 1
    set(handles.Silicon111, 'value', 0)
end

%%%%%%%%%%%%%%%%%%%%%%% oxidation_time_value_1 %%%%%%%%%%%%%%%%%%%%%%%%%%%
function oxidation_time_value_1_CreateFcn(hObject, eventdata, handles)

%%%%%%%%%%%%%%%%%%%%%%% axes_6 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function axes6_CreateFcn(hObject, eventdata, handles)

%%%%%%%%%%%%%%%%%%%%%%% solve_2 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function solve_2_Callback(hObject, eventdata, handles)

axes(handles.axes6);
k = 1.38*10^-23;
T2 = str2num(get(handles.set_temperature_2, 'string'));
t = str2num(get(handles.set_total_growth, 'string'));
tt = str2num(get(handles.set_total_growth_2, 'string'));
init_thickness = str2num(get(handles.set_initial_1, 'string'));

if isnan(t)
    t = 0;
    errordlg('Input must be a number','Error');
    set(hObject,'String',num2str(0));
end

check_4 = get(handles.Dry_O2_2, 'value');
check_5 = get(handles.H2O_2, 'value');
check_6 = get(handles.wet_O2_2, 'value');
check_7 = get(handles.Silicon100, 'value');
check_8 = get(handles.Silicon111, 'value');
Tick_1 = get(handles.Massoud, 'value');

if check_4 == 0 && check_5 == 0 && check_6 == 0
    errordlg('choose an Environment','Error');
end

if check_7 == 0 && check_8 == 0
    errordlg('choose Crystal Orientation','Error');
end

if tt > 0
    if t > 0
        t = t + (tt/60);
    else
        t = tt/60;
    end
end

init_thickness = init_thickness/10000;

if (check_4 == 1)
    C1 = 7.72*10^2; 
    E1 = (1.23)*(1.6*10^-19);
    E2 = (2.0)*(1.6*10^-19); 
    if (check_7 == 1)
        C2 = (6.23*10^6)/(1.68);
    elseif (check_8 == 1)
        C2 = (6.23*10^6);
    end
end

if (check_5 == 1)
    C1 = 3.86*10^2; 
    E1 = (0.78)*(1.6*10^-19);
    E2 = (2.05)*(1.6*10^-19);
    if (check_7 == 1)
        C2 = (1.63*10^8)/(1.68);
    elseif (check_8 == 1)
        C2 = (1.63*10^8);
    end
end

if (check_6 == 1)
    C1 = 2.14*10^2;
    E1 = (0.71)*(1.6*10^-19);  
	E2 = (2.05)*(1.6*10^-19); 
    if (check_7 == 1)
        C2 = (8.95*10^7)/(1.68);
    elseif (check_8 == 1)
        C2 = (8.95*10^7);
    end
end
    
B = C1*exp(-(E1)/((k)*(T2+273)));
BA = C2*exp(-(E2)/((k)*(T2+273)));

P1 = get(handles.Pressure_1,'value');
if P1 == 1
    P2 = str2num(get(handles.Pressure_2, 'string'));
    if (check_4 == 1) && (P2 > 0)  
        B = (B)*(P2);
        BA = (BA)*(P2^0.8);
    elseif (check_5 == 1) && (P2 > 0) || (check_6 == 1) && (P2 > 0)
        B = (B)*(P2);
        BA = (BA)*(P2);
    end
end

A = B/BA;
tau = ((init_thickness^2) + A*(init_thickness))/B;
x=(A/2)*(-1+sqrt(((4*B)/(A)^2)*(t+tau)+1));
x = x*10000; %Angstrom
set(handles.oxidation_time_value_1, 'string', x)

if Tick_1 == 1
    Temp = T2+273; k = 1.38*10^-23;
    Mt = t*60;
    C1 = 1.70*10^13; E1 = 2.22*(1.6*10^-19);
    B1 = C1*exp(-E1/(k*Temp));
    C2 = 7.35*10^7; E2 = 1.76*(1.6*10^-19);
    BA1 = C2*exp(-E2/(k*Temp));
    A1 = B1/BA1;
    %%%%%%%%%%%%%%%%% M0 %%%%%%%%%%%%%%%%%
    xi = str2num(get(handles.set_initial_1, 'string'));
    M0 = ((xi^2)+(A1*xi));
    %%%%%%%%%%%%%%%%% M1 %%%%%%%%%%%%%%%%%
    k01 = (2.49*10^13); Ek1 = 2.18*(1.6*10^-19);
    k1 = k01*exp(-Ek1/(k*Temp));
    tau01 = (4.14*10^-6); Etau1 = 1.38*(1.6*10^-19);
    tau1 = tau01*exp(Etau1/(k*Temp));
    M1 = k1*tau1;
    %%%%%%%%%%%%%%%%% M2 %%%%%%%%%%%%%%%%%
    k02 = (3.72*10^13); Ek2 = 2.28*(1.6*10^-19);
    k2 = k02*exp(-Ek2/(k*Temp));
    tau02 = (2.71*10^-7); Etau2 = 1.88*(1.6*10^-19);
    tau2 = tau02*exp(Etau2/(k*Temp));
    M2 = k2*tau2;
    %%%%%%%%%%%%%%%%% P1 %%%%%%%%%%%%%%%%%
    P1 = (A1/2)^2;
    %%%%%%%%%%%%%%%%% P2 %%%%%%%%%%%%%%%%%
    P2 = B1*Mt;
    %%%%%%%%%%%%%%%%% P3 %%%%%%%%%%%%%%%%%
    P3 = M1*(1-exp(-Mt/tau1));
    %%%%%%%%%%%%%%%%% P4 %%%%%%%%%%%%%%%%%
    P4 = M2*(1-exp(-Mt/tau2));
    %%%%%%%%%%%%%%%%% analutical solution %%%%%%%%%%%%%%%%%
    x = (sqrt(P1+P2+P3+P4+M0))-(A1/2);
    set(handles.oxidation_time_value_1, 'string', x)
end

t4 = [0:0.1:t]; N4 =  length(t4);
for z = 1:N4
    if Tick_1 == 0
        x1(z) =(A/2)*(-1+sqrt(((4*B)/(A)^2)*(t4(z)+tau)+1));
    elseif Tick_1 == 1
        t4(z) = t4(z)*60;
        P2 = B1*t4(z);
        P3 = M1*(1-exp(-t4(z)/tau1));
        P4 = M2*(1-exp(-t4(z)/tau2));
        x1(z) = (sqrt(P1+P2+P3+P4+M0))-(A1/2);
        x1(z) = x1(z)/10000;
    end
end
x1=x1*10000;
plot(t4, x1, 'LineWidth', 1.5); hold on;
plot(t4, x1, 'o', 'LineWidth', 1.5); grid on;
title('Oxide Thickness as a function of time');
if Tick_1 == 0
    xlabel('Time - hours'); ylabel('Oxide Thickness - Angstroms'); hold off;
elseif Tick_1 == 1
    xlabel('Time - mins'); ylabel('Oxide Thickness - Angstroms'); hold off;
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes(handles.axes7);
dry_O2_C1 = 7.72*10^2;
dry_O2_E1 = (1.23)*(1.6*10^-19); 
H2O_C1 = 3.86*10^2; 
H2O_E1 = (0.78)*(1.6*10^-19); 
dry_O2_E2 = (2.0)*(1.6*10^-19);  
H2O_E2 = (2.05)*(1.6*10^-19);
wet_O2_C1 = 2.14*10^2;
wet_O2_E1 = (0.71)*(1.6*10^-19); 
wet_O2_E2 = (2.05)*(1.6*10^-19);
k = 1.38*10^-23;
T = [700:50:1200]; 
N = length(T);

C0 = 6.57*10^10; 
Ea_100 = 2.37*(1.6*10^-19); Ea_111 = 2.32*(1.6*10^-19);   

if (check_7 == 1)
    dry_O2_C2 = (6.23*10^6)/(1.68);
    H2O_C2 = (1.63*10^8)/(1.68);
    wet_O2_C2 = (8.95*10^7)/(1.68);
elseif (check_8 == 1)
    dry_O2_C2 = (6.23*10^6);
    H2O_C2 = (1.63*10^8);
    wet_O2_C2 = (8.95*10^7);
end

for i = 1:N
    B_dry_O2(i) = dry_O2_C1*exp(-(dry_O2_E1)/((k)*(T(i)+273)));
    B_H2O(i) = H2O_C1*exp(-(H2O_E1)/((k)*(T(i)+273)));
    
    BA_dry_O2(i) = dry_O2_C2*exp(-(dry_O2_E2)/((k)*(T(i)+273)));
    BA_H2O(i) = H2O_C2*exp(-(H2O_E2)/((k)*(T(i)+273)));
    
    B_wet_O2(i) = wet_O2_C1*exp(-(wet_O2_E1)/((k)*(T(i)+273)));
    BA_wet_O2(i) = wet_O2_C2*exp(-(wet_O2_E2)/((k)*(T(i)+273)));
    
    CC_100(i) = C0*exp(-Ea_100/(k*(T(i)+273)));
    CC_111(i) = C0*exp(-Ea_111/(k*(T(i)+273)));
end

for j = 1:N
    T(j)=1000/(T(j)+274.15);
end

if check_4 == 1
    B_dry_O2_calc = dry_O2_C1*exp(-(dry_O2_E1)/((k)*(T2+273)));
    %x = B_dry_O2_calc; 
    BA_dry_O2_calc = dry_O2_C2*exp(-(dry_O2_E2)/((k)*(T2+273)));
    %y = BA_dry_O2_calc; 
    T2 = 1000/(T2+274.15);
    
    if Tick_1 == 0
        if P1 == 0
            set(handles.B_value_1, 'string', B_dry_O2_calc)
            set(handles.BA_value_1, 'string', BA_dry_O2_calc)
        elseif P1 == 1
            set(handles.B_value_1, 'string', B)
            set(handles.BA_value_1, 'string', BA)
        end
    elseif Tick_1 == 1
        B1 = (B1*10^-8)*60; BA1 = (BA1*10^-4)*60;
        set(handles.B_value_1, 'string', B1)
        set(handles.BA_value_1, 'string', BA1)
    end
    
    loglog(T, B_dry_O2, 'LineWidth', 2); hold on;
    loglog(T, BA_dry_O2, 'LineWidth', 2);
    %loglog(T2, x, 'o'); loglog(T2, y, 'o');
    xlabel('1000/T (Kelvin)'); ylabel('B microns^2/hr | B/A microns/hr');
    legend('B', 'B/A'); grid on;
    title('Rate constants for oxidation of silicon');
    hold off;
    
elseif check_5 == 1 
    B_H2O_calc = H2O_C1*exp(-(H2O_E1)/((k)*(T2+273)));
    x = B_H2O_calc;
    BA_H2O_calc = H2O_C2*exp(-(H2O_E2)/((k)*(T2+273)));
    y = BA_H2O_calc; T2 = 1000/(T2+274.15);
    set(handles.B_value_1, 'string', B_H2O_calc)
    set(handles.BA_value_1, 'string', BA_H2O_calc)
    
    loglog(T, B_H2O, 'LineWidth', 2); hold on;
    loglog(T, BA_H2O, 'LineWidth', 2);
    loglog(T2, x, 'o'); loglog(T2, y, 'o');
    xlabel('1000/T (Kelvin)'); ylabel('B microns^2 hr^-1 | B/A microns hr^-1');
    legend('B', 'B/A'); grid on;
    title('Rate constants for oxidation of silicon');
    hold off;

elseif check_6 == 1 
    B_wet_O2_calc = wet_O2_C1*exp(-(wet_O2_E1)/((k)*(T2+273)));
    x = B_wet_O2_calc; 
    BA_wet_O2_calc = wet_O2_C2*exp(-(wet_O2_E2)/((k)*(T2+273)));
    y = BA_wet_O2_calc; T2 = 1000/(T2+274.15);
    set(handles.B_value_1, 'string', B_wet_O2_calc)
    set(handles.BA_value_1, 'string', BA_wet_O2_calc)
    
    loglog(T, B_wet_O2, 'LineWidth', 2); hold on;
    loglog(T, BA_wet_O2, 'LineWidth', 2); 
    loglog(T2, x, 'o'); loglog(T2, y, 'o');
    xlabel('1000/T (Kelvin)'); ylabel('B microns^2 hr^-1 | B/A microns hr^-1');
    legend('B', 'B/A'); grid on;
    title('Rate constants for oxidation of silicon');
    hold off;
end

    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% --- Executes on button press in Massoud.
function Massoud_Callback(hObject, eventdata, handles)
% hObject    handle to Massoud (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of Massoud

function Massoud_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Pressure_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% --- Executes on button press in Learn_more_1.
function Learn_more_1_Callback(hObject, eventdata, handles)
% hObject    handle to Learn_more_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
msgbox(...
'Massoud limiation: dry ambient only, temperature(800-1000), not Thick'...
,'Massoud Model');

function Pressure_1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Pressure_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% --- Executes on button press in Pressure_1.
function Pressure_1_Callback(hObject, eventdata, handles)
% hObject    handle to Pressure_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
P1 = get(handles.Pressure_1, 'value');
if P1 == 1
    set(handles.Pressure_2, 'enable', 'on')
elseif P1 ==0
    set(handles.Pressure_2, 'enable', 'off')
end
% Hint: get(hObject,'Value') returns toggle state of Pressure_1

% --- Executes during object creation, after setting all properties.
function test_1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to test_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

function Pressure_2_Callback(hObject, eventdata, handles)
% hObject    handle to Pressure_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Pressure_2 as text
%        str2double(get(hObject,'String')) returns contents of Pressure_2 as a double

% --- Executes during object creation, after setting all properties.
function Pressure_2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Pressure_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on selection change in Lower_graph_2.
function Lower_graph_2_Callback(hObject, eventdata, handles)
% hObject    handle to Lower_graph_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns Lower_graph_2 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from Lower_graph_2

% --- Executes during object creation, after setting all properties.
function Lower_graph_2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Lower_graph_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function Oxidation_Rate_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Oxidation_Rate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes on button press in Home.
function Home_Callback(hObject, eventdata, handles)
% hObject    handle to Home (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
close(test_model_1);
Main_GUI;


% --- Executes on button press in Help_fun.
function Help_fun_Callback(hObject, eventdata, handles)
% hObject    handle to Help_fun (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
url = 'http://www.lelandstanfordjunior.com/oxcalcfaq.html#models';
web(url)
