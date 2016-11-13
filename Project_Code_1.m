% Producing curves (6.18)&(6.19)&(6.20) in the Plummer book
% Code written by Khaled Aladwani || Student no.: D12124627
close all; clear all; clc;

% B and B/A for O2 and H2O oxidaton of <111> silicon.
% Values taken from the parameters in Table 6-2 in the Plummer book
% First, C1 in um^2 hr^-1 && E1 in eV for B Dry O2: 
dry_O2_C1 = 7.72*10^2;
dry_O2_E1 = (1.23)*(1.6*10^-19); 
% Second, C1 in um^2 hr^-1 && E1 in eV for B H2O:
H2O_C1 = 3.86*10^2; 
H2O_E1 = (0.78)*(1.6*10^-19);
% Third, C2 in um hr^-1 && E2 in eV for B/A Dry O2:
dry_O2_C2 = (6.23*10^6)/(1.68); 
dry_O2_E2 = (2.0)*(1.6*10^-19); 
% Fourth, C2 in um hr^-1 && E2 in eV for B/A H2O:
H2O_C2 = (1.63*10^8)/(1.68); 
H2O_E2 = (2.05)*(1.6*10^-19);
% Temperature array (x-axis but with rescaling later)
k = 1.38*10^-23;
T = [700:50:1400]; 
N = length(T);
% implementing equations (6.29)&(6.30) in the Plummer book
% Arrhenius expressions
for i = 1:N
    B_dry_O2(i) = dry_O2_C1*exp(-(dry_O2_E1)/((k)*(T(i)+273)));
    B_H2O(i) = H2O_C1*exp(-(H2O_E1)/((k)*(T(i)+273)));
    
    BA_dry_O2(i) = dry_O2_C2*exp(-(dry_O2_E2)/((k)*(T(i)+273)));
    BA_H2O(i) = H2O_C2*exp(-(H2O_E2)/((k)*(T(i)+273)));
end
% rescalling the Temperature to be (1000/T (Kelvin)) as the x-axis 
for j = 1:N
    T(j)=1000/(T(j)+274.15);
end
% plot the B and B/A for O2 and H2O oxidaton of <111> silicon
figure(1); loglog(T, B_dry_O2, 'LineWidth', 2); hold on;
loglog(T, B_H2O, 'LineWidth', 2);
loglog(T, BA_dry_O2, 'LineWidth', 2);
loglog(T, BA_H2O, 'LineWidth', 2);
xlabel('1000/T (Kelvin)'); ylabel('B um^2 hr^-1 | B/A um hr^-1');
legend('B Dry O2', 'B H2O', 'B/A Dry O2', 'B/A H2O'); grid on;


% Calculated oxidation rates for (100) silicon in
% 1- dry O2 based on the Deal-Grove model
% 2- H2O based on the Deal-Grove model
clear all;

dry_O2_C1 = 7.72*10^2; dry_O2_E1 = (1.23)*(1.6*10^-19);  
H2O_C1 = 3.86*10^2; H2O_E1 = (0.78)*(1.6*10^-19);
k = 1.38*10^-23;

T = [800:100:1200];
N = length(T);

for i = 1:N
    t = [0:10]; N1 = length(t);
    B_dry_O2(i) = dry_O2_C1*exp(-(dry_O2_E1)/((k)*(T(i)+273)));
    B_H2O(i) = H2O_C1*exp(-(H2O_E1)/((k)*(T(i)+273)));
    
    for j = 1:N1
        x(j) = sqrt((B_dry_O2(i))*(t(j)));
        y(j) = sqrt((B_H2O(i))*(t(j)));
    end
    figure(2); plot(t, x, 'LineWidth', 2); hold on;
    figure(3); plot(t, y, 'LineWidth', 2); hold on;
end

figure(2); legend('800', '900', '1000', '1100', '1200'); grid on;
xlabel('Time - hours'); ylabel('Oxide Thickness - microns');
figure(3); legend('800', '900', '1000', '1100', '1200'); grid on;
xlabel('Time - hours'); ylabel('Oxide Thickness - microns');
