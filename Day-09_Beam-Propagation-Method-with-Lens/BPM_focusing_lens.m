%BPM_focusing_lens.m
%simulation of gaussian beam focused by a lens using BPM
%parameters suggested for simulation :
%ld(light wavelength)= 0.633,wo(waist)=10,
%dz(sample distance along z)=800,z(total final distance away from lens )=40000,
%f(focal length)=16000
clear
%Gaussian beam
N=255; %N : sampling number
L=50*10^-3; %display area
Ld=input('wavelength of light in [micrometer]=?');
Ld=Ld*10^-6;
ko=(2*pi)/Ld;
wo=input('waist of gassian beam in [mm]=?');
wo = wo * 10^-3; % Convert waist from mm to meters
dz = input('step size of z (dz) in [mm]=?');
dz=dz*10^-3;
Z=input('destination of z in [mm]=?');
Z=Z*10^-3;
%focal length of lens
f=input('focal length of lens in[mm]=?');
f = f * 10^-3; % Convert focal length from mm to meters
%dx; step size
dx = L / N; % Calculate the step size in the x-direction
for n=1:256
    for m=1:256
        %Space axis
        x(m) = (m - 1) * dx - L/2; % Define the x-axis coordinates
        y(n) = (n - 1) * dx - L/2; % Define the y-axis coordinates
        %frequency axis
        Kx(m) = (2*pi*(m-1))/(N*dx)-((2*pi*(256-1))/(N*dx))/2;
        Ky(n) = (2*pi*(n-1))/(N*dx)-((2*pi*(256-1))/(N*dx))/2;
    end
end
% Initialize the Gaussian beam profile
[X, Y] = meshgrid(x, y);
[KX,KY]=meshgrid(Kx,Kx);
% Calculate the Gaussian beam profile
Gau_ini = (1/(wo*pi^0.5)) * exp(-(X.^2 + Y.^2) / wo^2);
%energy of the initial gaussian beam 
% Calculate the energy of the initial Gaussian beam
Energy_ini = dx*dx*sum(sum(abs(Gau_ini).^2))
%lens equation 
L=exp(j*ko/(2/f)*(X.^2+Y.^2));
% Propagate the Gaussian beam through the lens
Gau_ini = Gau_ini .* L; % Apply the lens effect to the initial Gaussian beam

%free space tranfer function of propagation 
H=exp(j/(2*ko)*dz*(KX.^2+KY.^2));

%iterative loop
% Initialize the propagation variable
Gau = Gau_ini;
n1=0;
for z=0:dz:Z
    n1=n1+1;
    Zp(n1)=z+dz;
    %gaussian beam in frequency domain
    FGau=fft2(Gau);
    %propagated gaussian beam in frequency domain
    FGau=FGau.*fftshift(H);
    % Propagate the Gaussian beam in space domain
    Gau = ifft2(FGau);
    %step propagation through medium
    Gau_pro(:,n1)=Gau(:,127);
end
    % energy of the final propagated gaussian beam,
    %to check conservation of energy 
    Energy_pro = dx * dx * sum(sum(abs(Gau).^2))
    %axis in mm scale 
    x=x*10^3;
    y=y*10^3;
    Zp=Zp*10^3;
    MAX1=max(max(abs(Gau_ini)));
    % Calculate the maximum intensity of the final propagated Gaussian beam
    MAX2 = max(max(abs(Gau)));
    MAX=max([MAX1 MAX2]);

    figure(1);
    mesh(x,y,abs(Gau_ini))
    title('initial gaussian beam')
    xlabel('x[mm]')
    ylabel('y[mm]')
    axis([min(x) max(x) min(y) max(y) 0 MAX])
    axis square
    % Plot the final propagated Gaussian beam
figure(2);
mesh(x, y, abs(Gau));
title('Propagated Gaussian Beam at Z');
xlabel('x[mm]');
ylabel('y[mm]');
axis([min(x) max(x) min(y) max(y) 0 MAX]);
axis square;

figure(3)
for l=1:n1
    plot3(x',Zp(l)*ones(size(x')),abs(Gau_pro(:,l)))
    hold on
end
axis([min(x) max(x) min(Zp) max(Zp)])
grid on
title ('beam profile along z')
xlabel('x[mm]')
ylabel('y[mm]')
hold off
figure(4)
A=max(abs(Gau_pro));
B=diag(1./A);
N_Gau_pro=abs(Gau_pro)*B;
contour(Zp,x,N_Gau_pro,[exp(-1) exp(-1)],'k')
grid on
title('beam waist along z')
xlabel('z[mm]')
ylabel('x[mm]')
