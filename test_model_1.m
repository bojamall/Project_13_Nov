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


function varargout = test_model_1_OutputFcn(hObject, eventdata, handles) 

varargout{1} = handles.output;


function set_temperature_Callback(hObject, eventdata, handles)


function set_temperature_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function Dry_O2_1_Callback(hObject, eventdata, handles)

check_1 = get(handles.Dry_O2_1, 'value');

if check_1 == 1
    set(handles.H2O_1, 'value', 0)
end

function H2O_1_Callback(hObject, eventdata, handles)

check_2 = get(handles.H2O_1, 'value');

if check_2 == 1
    set(handles.Dry_O2_1, 'value', 0)
end

function Solve_1_Callback(hObject, eventdata, handles)

axes(handles.axes2);

dry_O2_C1 = 7.72*10^2;
dry_O2_E1 = (1.23)*(1.6*10^-19); 
H2O_C1 = 3.86*10^2; 
H2O_E1 = (0.78)*(1.6*10^-19);
dry_O2_C2 = (6.23*10^6)/(1.68); 
dry_O2_E2 = (2.0)*(1.6*10^-19); 
H2O_C2 = (1.63*10^8)/(1.68); 
H2O_E2 = (2.05)*(1.6*10^-19);
k = 1.38*10^-23;
T = [700:50:1400]; 
N = length(T);

for i = 1:N
    B_dry_O2(i) = dry_O2_C1*exp(-(dry_O2_E1)/((k)*(T(i)+273)));
    B_H2O(i) = H2O_C1*exp(-(H2O_E1)/((k)*(T(i)+273)));
    
    BA_dry_O2(i) = dry_O2_C2*exp(-(dry_O2_E2)/((k)*(T(i)+273)));
    BA_H2O(i) = H2O_C2*exp(-(H2O_E2)/((k)*(T(i)+273)));
end

for j = 1:N
    T(j)=1000/(T(j)+274.15);
end

T1 = str2num(get(handles.set_temperature, 'string'));

Dry_selected = get(handles.Dry_O2_1, 'value');
H2O_selected = get(handles.H2O_1, 'value');

if Dry_selected == 1 && H2O_selected == 0
    
    B_dry_O2_calc = dry_O2_C1*exp(-(dry_O2_E1)/((k)*(T1+273)));
    BA_dry_O2_calc = dry_O2_C2*exp(-(dry_O2_E2)/((k)*(T1+273)));
    set(handles.B_value_1, 'string', B_dry_O2_calc)
    set(handles.BA_value_1, 'string', BA_dry_O2_calc)
    
    loglog(T, B_dry_O2, 'LineWidth', 2); hold on;
    loglog(T, BA_dry_O2, 'LineWidth', 2); 
    xlabel('1000/T (Kelvin)'); ylabel('B um^2 hr^-1 | B/A um hr^-1');
    legend('B Dry O2', 'B/A Dry O2'); grid on;
    hold off;
elseif Dry_selected == 0 && H2O_selected == 1
    
    B_H2O_calc = H2O_C1*exp(-(H2O_E1)/((k)*(T1+273)));
    BA_H2O_calc = H2O_C2*exp(-(H2O_E2)/((k)*(T1+273)));
    set(handles.B_value_1, 'string', B_H2O_calc)
    set(handles.BA_value_1, 'string', BA_H2O_calc)
    
    loglog(T, B_H2O, 'LineWidth', 2); hold on;
    loglog(T, BA_H2O, 'LineWidth', 2);
    xlabel('1000/T (Kelvin)'); ylabel('B um^2 hr^-1 | B/A um hr^-1');
    legend('B H2O', 'B/A H2O'); grid on;
    hold off;
elseif Dry_selected == 0 && H2O_selected == 0
    set(handles.B_value_1, 'string', '0')
    set(handles.BA_value_1, 'string', '0')
    msgbox('Error select the Environment !!');
% elseif Dry_selected == 1 && H2O_selected == 1
%     set(handles.B_value_1, 'string', '!!!!!!!')
%     set(handles.BA_value_1, 'string', '!!!!!!!')
%     msgbox('Error select only one Environment !!');
end
    


function set_temperature_2_Callback(hObject, eventdata, handles)

check_5 = get(handles.set_temperature_2, 'value');

if check_5 == 1
    set(handles.set_temperature_3, 'value', 0)
end

function Dry_O2_2_Callback(hObject, eventdata, handles)

check_3 = get(handles.Dry_O2_2, 'value');

if check_3 == 1
    set(handles.H2O_2, 'value', 0)
end

function H2O_2_Callback(hObject, eventdata, handles)

check_4 = get(handles.H2O_2, 'value');

if check_4 == 1
    set(handles.Dry_O2_2, 'value', 0)
end

function set_temperature_3_Callback(hObject, eventdata, handles)

check_6 = get(handles.set_temperature_3, 'value');

if check_6 == 1
    set(handles.set_temperature_2, 'value', 0)
end

function set_total_growth_Callback(hObject, eventdata, handles)


function set_total_growth_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function solve_2_Callback(hObject, eventdata, handles)

axes(handles.axes4);

Dry_selected_2 = get(handles.Dry_O2_2, 'value');
H2O_selected_2 = get(handles.H2O_2, 'value');

temp_selected_1 = get(handles.set_temperature_2, 'value');
temp_selected_2 = get(handles.set_temperature_3, 'value');

dry_O2_C1 = 7.72*10^2; dry_O2_E1 = (1.23)*(1.6*10^-19);  
H2O_C1 = 3.86*10^2; H2O_E1 = (0.78)*(1.6*10^-19);

dry_O2_C2 = (6.23*10^6)/(1.68); 
dry_O2_E2 = (2.0)*(1.6*10^-19); 
H2O_C2 = (1.63*10^8)/(1.68); 
H2O_E2 = (2.05)*(1.6*10^-19);

k = 1.38*10^-23;
t = [0:10]; N1 = length(t);

if temp_selected_1 == 1
    T2 = 900;
    legend('900');
elseif temp_selected_2 == 1
    T2 = 1000;
    legend('1000');
end

if Dry_selected_2 == 1
    
    B_dry_O2 = dry_O2_C1*exp(-(dry_O2_E1)/((k)*(T2+273)));
    
    for j = 1:N1
        x(j) = sqrt((B_dry_O2)*(t(j)));
    end
    plot(t, x, 'LineWidth', 2); grid on;
    xlabel('Time - hours'); ylabel('Oxide Thickness - microns');
    if temp_selected_1 == 1
        legend('O2 at 900 oC');
    elseif temp_selected_2 == 1
        legend('O2 at 1000 oC');
    end
    
elseif H2O_selected_2 == 1
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    B_H2O_calc_2 = H2O_C1*exp(-(H2O_E1)/((k)*(T2+273)));
    BA_H2O_calc_2 = H2O_C2*exp(-(H2O_E2)/((k)*(T2+273)));
    
    x0_1 = str2num(get(handles.set_total_growth, 'string'));
    oxidation_time = ((x0_1^2)/(B_H2O_calc_2))+((x0_1)/(BA_H2O_calc_2));
    set(handles.oxidation_time_value_1, 'string', oxidation_time)
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    B_H2O = H2O_C1*exp(-(H2O_E1)/((k)*(T2+273)));
    
    for j = 1:N1  
        y(j) = sqrt((B_H2O)*(t(j)));
    end
    plot(t, y, 'LineWidth', 2); grid on;
    xlabel('Time - hours'); ylabel('Oxide Thickness - microns');
    if temp_selected_1 == 1
        legend('H2O at 900 oC');
    elseif temp_selected_2 == 1
        legend('H2O at 1000 oC');
    end
end


function axes2_CreateFcn(hObject, eventdata, handles)


function axes4_CreateFcn(hObject, eventdata, handles)
