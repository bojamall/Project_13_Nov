function varargout = Ion_Implantation(varargin)

gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Ion_Implantation_OpeningFcn, ...
                   'gui_OutputFcn',  @Ion_Implantation_OutputFcn, ...
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


function Ion_Implantation_OpeningFcn(hObject, eventdata, handles, varargin)

handles.output = hObject;

guidata(hObject, handles);
movegui(gcf,'center')
set(handles.Arsenic_1, 'value', 1)
set(handles.Dose_1, 'string', 2e15)

function varargout = Ion_Implantation_OutputFcn(hObject, eventdata, handles) 

varargout{1} = handles.output;

function Solve_1_Callback(hObject, eventdata, handles)

As = get(handles.Arsenic_1, 'value');
P = get(handles.Phosphorus_1, 'value');
B = get(handles.Boron_1, 'value');

E = str2num(get(handles.Energy_1, 'string'));
Dose = str2num(get(handles.Dose_1, 'string'));
x = str2num(get(handles.Depth_1, 'string'));

Delta_x = 1e-6;
X = [0:(Delta_x*1e3):(x+4e6)*Delta_x];

if B == 1
    RSi = [0.0658, 0.1277, 0.1847, 0.2380, 0.2887, 0.3362, 0.3812, ...
        0.4242, 0.4654, 0.5050];
    SSi = [0.0270, 0.0423, 0.0526, 0.0605, 0.0669, 0.0721, 0.0764, ...
        0.0801, 0.0833, 0.0862];
elseif As == 1
    RSi = [0.0150, 0.0262, 0.0368, 0.0473, 0.0577, 0.0682, 0.0788, ...
        0.0894, 0.1001, 0.1109];
    SSi = [0.0056, 0.0096, 0.0133, 0.0169, 0.0204, 0.0237, 0.0269, ...
        0.0302, 0.0334, 0.0368];
elseif P == 1
    RSi = [0.0253, 0.0488, 0.0729, 0.0974, 0.1226, 0.1479, 0.1732, ...
        0.1988, 0.2247, 0.2506];
    SSi = [0.0114, 0.0201, 0.0288, 0.0367, 0.0445, 0.0516, 0.0581, ...
        0.0642, 0.0702, 0.0762];
end

index1 = round(E/20);
if ((E/20) < index1) || (index1 == 10)
    index2 = index1-1;
else
    index2 = index1+1;
end

if (index2 > index1)
    mR = RSi(index2-index1);
else
    mR = RSi(index1-index2);
end
Range = mR*((E/20)-index1)+RSi(index1);
set(handles.Range_1, 'string', Range)

if (index2 > index1)
    mS = SSi(index2-index1);
else
    mS = SSi(index1-index2);
end
Straggle = mS*((E/20)-index1)+SSi(index1);
set(handles.Straggle_1, 'string', Straggle)

Cp = Dose/((sqrt(2*pi))*Straggle*10^-4);
Ex = exp(-(X-Range).^2/((2*Straggle^2)));
C = (Cp*Ex);
% plot(X, C, 'Linewidth', 1.5); grid on;
semilogy(X, C, 'Linewidth', 1.5); grid on;
xlabel('Substrate Depth x (um)', 'FontSize',10);
ylabel('Concentration (cm^{-3})', 'FontSize',10);
if B == 1
    title({'Boron Profile implented into a silicon wafer';...
        ['The implant energy is ' num2str(E) 'keV']},'FontSize',10);
elseif As == 1
    title({'Arsenic Profile implented into a silicon wafer';...
        ['The implant energy is ' num2str(E) 'keV']},'FontSize',10);
elseif P == 1
    title({'Phosphorus Profile implented into a silicon wafer';...
        ['The implant energy is ' num2str(E) 'keV']},'FontSize',10);
end
R = round(x*1e3);
if R > 0 && R <= 4*1e3
    set(handles.Result_1, 'string', C(R))
elseif R == 0 || R < 0 || R > 4*1e3
    set(handles.Result_1, 'string', 0)
end


function Depth_1_Callback(hObject, eventdata, handles)
segmentlen = str2double(get(hObject,'string'));
if isnan(segmentlen) || (segmentlen < 0)
    segmentlen = 0;
    errordlg('Input must be a number within the range','Error');
    set(hObject,'String',num2str(segmentlen));
end

function Depth_1_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function Energy_1_Callback(hObject, eventdata, handles)
segmentlen = str2double(get(hObject,'string'));
if isnan(segmentlen) || (segmentlen > 200) || (segmentlen < 0)
    segmentlen = 0;
    errordlg('Input must be a number within the range','Error');
    set(hObject,'String',num2str(segmentlen));
end

function Energy_1_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function Dose_1_Callback(hObject, eventdata, handles)
segmentlen = str2double(get(hObject,'string'));
if isnan(segmentlen) || (segmentlen < 0)
    segmentlen = 0;
    errordlg('Input must be a number within the range','Error');
    set(hObject,'String',num2str(segmentlen));
end

function Dose_1_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function Phosphorus_1_Callback(hObject, eventdata, handles)
check_3 = get(handles.Phosphorus_1, 'value');
if check_3 == 1
    set(handles.Arsenic_1, 'value', 0)
    set(handles.Boron_1, 'value', 0)
end

function Boron_1_Callback(hObject, eventdata, handles)
check_1 = get(handles.Boron_1, 'value');
if check_1 == 1
    set(handles.Phosphorus_1, 'value', 0)
    set(handles.Arsenic_1, 'value', 0)
end

function Arsenic_1_Callback(hObject, eventdata, handles)
check_2 = get(handles.Arsenic_1, 'value');
if check_2 == 1
    set(handles.Phosphorus_1, 'value', 0)
    set(handles.Boron_1, 'value', 0)
end

function Home_Callback(hObject, eventdata, handles)
close(Ion_Implantation);
Main_GUI;
