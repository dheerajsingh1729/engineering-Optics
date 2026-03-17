%BPM_sq_law_medium.m
%simulation of gaussian beam propagation in a square law medium using bpm
%this progrAM DEMONSTRATES periodically focusing and defocusing 
%suggested simulation parameters 
%for initially converging situation:
%L=20
%Ld=0.633;
%wo=5;
%dz=2000;
%z=80000
%for initially diverging situation:
%l=15
%ld=0.633;
%wo=1
%dz=2000
%z=80000
clear
n0=1.5;
n2=0.01;%with unit of (meter)^-2
%gaussian beam
%N:sampling number
N = 255;
L=input('length of back ground in [mm] = ?');
L=L*10^-3;
Ld=input('incident wavelength of light in [micrometer]=?');
Ld=(Ld/n0)*10^-6;
Ko=(2*pi)/Ld;%wavenumber in n0
wo=input('waist of gausssian beam in[mm]=?');
wo = wo * 10^-3; % Convert waist of Gaussian beam from mm to meters
dz=input('step size of z in [mm]=?');
dz = dz * 10^-3;
Z=input('destination of z in [mm]=?');
Z = Z * 10^-3;
%dx:step size
dx = L / N; % Calculate the step size in the x-direction
for n=1:256
    for m=1:256
        %space axis 
        x(m)=(m-1)*dx-L/2;
        y(n)=(n-1)*dx-L/2;
        %frequency axis
        Kx(m)=(2*pi*(m-1))/(N*dx)-((2*pi*(256-1))/(N*dx))/2;
        Ky(n)=(2*pi*(n-1))/(N*dx)-((2*pi*(256-1))/(N*dx))/2;
    end
end
[X,Y]=meshgrid(x,y);
[KX,KY]=meshgrid(Kx,Kx);
%gaussian beam in space domain 
Gau_ini=(1/(wo*pi^0.5))*exp(-(X.^2+Y.^2)/(wo^2));

%energy of the initial gaussian beam 
% Calculate the energy of the initial Gaussian beam
Energy_ini = dx*dx*sum(sum(abs(Gau_ini).^2))
%free space transfer function of step propagation 
H=exp(1j/(2*Ko)*dz*(KX.^2 + KY.^2));

%s operator according to index profile of medium 
S=-j*(-n2/(2*n0*n0)*(X.^2 + Y.^2))*Ko;
% iterative loop 
Gau=Gau_ini;
n1=0;
for z=0:dz:Z
    n1=n1+1;
    Zp(n1)=z+dz;
    %gaussian beam in frequency domain
    FGau=fft2(Gau);
    %propagated gaussian beam in frequency domain
    FGau=FGau.*fftshift(H);
    % Propagated  Gaussian beam in space domain
    Gau = ifft2(FGau);
    %step propagation through medium
    Gau=Gau.*exp(S*dz);
    Gau_pro(:,n1)=Gau(:,127);
end
%energy of the final propagated gaussian beam 
% Calculate the energy of the final propagated Gaussian beam
Energy_Pro = dx*dx*sum(sum(abs(Gau).^2));
%axis in mm scale 
x=x*10^3;
y=y*10^3;
Zp=Zp*10^3;
MAX1=max(max(abs(Gau_ini)));
MAX2=max(max(abs(Gau)));
MAX=max([MAX1 MAX2]);
figure(1);
mesh(x,y,abs(Gau_ini))
title('initial gaussian beam')
xlabel('x[mm]')
ylabel('y[mm]')
axis([min(x) max(x) min(y) max(y) 0 MAX])
axis square
figure(2);
% Plot the final propagated Gaussian beam
mesh(x, y, abs(Gau));
title('Propagated gaussian beam')
xlabel('x [mm]')
ylabel('y [mm]')
axis([min(x) max(x) min(y) max(y) 0 MAX]);
axis square;
figure(3)
for l=1:n1
    plot3(x',Zp(l)*ones(size(x')),abs(Gau_pro(:,l)))
    hold on
end
grid on
axis([min(x) max(x) min(Zp) max(Zp)])
title('beam profile along z')
xlabel('x[mm]')
ylabel('y[mm]')
hold off
w00=(2/((Ko/n0)*(n2^0.5)))^0.5;%fundamental mode width
w00=w00*10^3;
sprintf('w00,fumdamental mode width in [mm] %f' ,w00)
figure(4)
A=max(abs(Gau_pro));
B=diag(1./A);
N_Gau_pro= abs(Gau_pro)*B;
contour(Zp,x,N_Gau_pro,[exp(-1) exp(-1)],'k')
figure(4)
A=max(abs(Gau_pro));
B=diag(1./A);
N_Gau_pro=abs(Gau_pro)*B;
contour(Zp,x,N_Gau_pro,[ exp(-1) exp(-1)],'k')
grid on
title('Beam width along z')
xlabel('z[mm]')
ylabel('x[mm]')


zm=pi*n0/((n2^0.5)); %modulation period 
% Calculate the modulation period in mm
zm = zm * 10^3; 
sprintf('zm,Modulation period in [mm]: %f', zm);
