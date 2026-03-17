% fresnel_eq.m
% This m-file plots Fresnel equations (2.2-46) and (2.2-47)

clc; clear; close all;

n1 = input('n1 = ');
n2 = input('n2 = ');

% Incidence angle (radians)
theta_i = 0:0.001:pi/2;

% Transmission angle (complex form for TIR)
z = (n1/n2)*sin(theta_i);
theta_t = -1i*log(1i*z + sqrt(ones(size(z)) - z.^2));

% Fresnel coefficients
r_pa = (n2*cos(theta_i) - n1*cos(theta_t)) ./ ...
       (n2*cos(theta_i) + n1*cos(theta_t));
t_pa = (2*n1*cos(theta_i)) ./ ...
       (n2*cos(theta_i) + n1*cos(theta_t));

r_pe = (n1*cos(theta_i) - n2*cos(theta_t)) ./ ...
       (n1*cos(theta_i) + n2*cos(theta_t));
t_pe = (2*n1*cos(theta_i)) ./ ...
       (n1*cos(theta_i) + n2*cos(theta_t));

% Brewster angle (minimum reflection for p-pol)
[~, M] = min(abs(r_pa));

% Convert angles to degrees
theta_i = theta_i * 180/pi;
theta_cri = asin(n2/n1) * 180/pi;

%% -------- FIGURE 1 : REAL PART --------
figure(1)
plot(theta_i,real(t_pa),'-', ...
     theta_i,real(t_pe),':', ...
     theta_i,real(r_pa),'-.', ...
     theta_i,real(r_pe),'--', ...
     theta_i(M),0,'o')
m1 = min([real(t_pa) real(t_pe) real(r_pa) real(r_pe)]);
M1 = max([real(t_pa) real(t_pe) real(r_pa) real(r_pe)]);
legend('t_{pa}','t_{pe}','r_{pa}','r_{pe}')
text(theta_i(M),0.01*(M1-m1),'\leftarrow')
text(theta_i(M),0.02*(M1-m1),['Brewster angle = ',num2str(theta_i(M))])
if n1 >= n2
    text(theta_cri,-0.1*(M1-m1),['Critical angle = ',num2str(theta_cri)])
end
xlabel('Incident angle (deg)')
axis([0 90 m1*1.1 M1*1.1])
title('Real part of coefficients')
grid on

%% -------- FIGURE 2 : IMAGINARY PART --------
figure(2)
plot(theta_i,imag(t_pa),'-', ...
     theta_i,imag(t_pe),':', ...
     theta_i,imag(r_pa),'-.', ...
     theta_i,imag(r_pe),'--', ...
     theta_i(M),0,'o')
m1 = min([imag(t_pa) imag(t_pe) imag(r_pa) imag(r_pe)]);
M1 = max([imag(t_pa) imag(t_pe) imag(r_pa) imag(r_pe)]);
legend('t_{pa}','t_{pe}','r_{pa}','r_{pe}')
text(theta_i(M),0.01*(M1-m1),'\leftarrow')
text(theta_i(M),0.02*(M1-m1),['Brewster angle = ',num2str(theta_i(M))])
if n1 >= n2
    text(theta_cri,-0.1*(M1-m1),['Critical angle = ',num2str(theta_cri)])
end
xlabel('Incident angle (deg)')
axis([0 90 m1*1.1 M1*1.1])
title('Imaginary part of coefficients')
grid on

%% -------- FIGURE 3 : MAGNITUDE --------
figure(3)
plot(theta_i,abs(t_pa),'-', ...
     theta_i,abs(t_pe),':', ...
     theta_i,abs(r_pa),'-.', ...
     theta_i,abs(r_pe),'--', ...
     theta_i(M),0,'o')
m1 = min([abs(t_pa) abs(t_pe) abs(r_pa) abs(r_pe)]);
M1 = max([abs(t_pa) abs(t_pe) abs(r_pa) abs(r_pe)]);
legend('t_{pa}','t_{pe}','r_{pa}','r_{pe}')
text(theta_i(M),0.01*(M1-m1),'\leftarrow')
text(theta_i(M),0.02*(M1-m1),['Brewster angle = ',num2str(theta_i(M))])
if n1 >= n2
    text(theta_cri,-0.1*(M1-m1),['Critical angle = ',num2str(theta_cri)])
end
xlabel('Incident angle (deg)')
axis([0 90 m1*1.1 M1*1.1])
title('Magnitude of coefficients')
grid on

%% -------- FIGURE 4 : PHASE --------
figure(4)
plot(theta_i,angle(t_pa)*180/pi,'-', ...
     theta_i,angle(t_pe)*180/pi,':', ...
     theta_i,angle(r_pa)*180/pi,'-.', ...
     theta_i,angle(r_pe)*180/pi,'--', ...
     theta_i(M),0,'o')
legend('t_{pa}','t_{pe}','r_{pa}','r_{pe}')
text(theta_i(M),10,'\leftarrow')
text(theta_i(M),20,['Brewster angle = ',num2str(theta_i(M))])
if n1 >= n2
    text(theta_cri,-160,['Critical angle = ',num2str(theta_cri)])
end
xlabel('Incident angle (deg)')
axis([0 90 -180 180])
title('Phase angle of coefficients')
grid on
