%gaussian_propagation.m
%simulation of diffraction of gaussian beam
clear
%gaussian beam
%N=:sampling num
N=input('num of samples(enter from 100 to 500)=');
L=10*10^-3;
Ld=input('wavelength of light in [micrometers]=');
Ld=Ld*10^-6;
ko=(2*pi)/Ld;
wo=input('waist of gaussian beam in [mm]=');
wo=wo*10^-3;
z_ray=(ko*wo^-2)/2*10^3;
sprintf('rayleigh range is %f [mm]',z_ray)
z_ray=z_ray*10^-3;
z=input('propagation length(z) in [mm]=');
z = z * 10^-3; % Convert propagation length to meters
%dx: step size
dx=L/N;
for n=1:N+1
    for m=1:N+1
        x(m)=(m-1)*dx-L/2;
        y(n)=(n-1)*dx-L/2;
        
        %gaussian beam in space domain
        Gau(n, m) = exp(-(x(m)^2+y(n)^2)/(wo^2));
        %frequency axis
        Kx(m)=(2*pi*(m-1))/(N*dx)-((2*pi*(N))/(N*dx))/2;
        Ky(n)=(2*pi*(n-1))/(N*dx)-((2*pi*(N))/(N*dx))/2;
        %free space transfer function 
        H(n,m)=exp(j/(2*ko)*z*(Kx(m)^2 + Ky(n)^2));
    end
end
%gaussian beam in frequency domain
FGau=fft2(Gau);
FGau=fftshift(FGau);
% Apply the free space transfer function to the Gaussian beam in frequency domain
FGau_pro = FGau .* H;
%peak amplitude of the initial gaussian beam 
Peak_ini = max(max(abs(Gau)));
sprintf('initial peak amplitude is %f[mm]', Peak_ini);
%propagated gaussian beam in space domain
Gau_pro = ifft2(FGau_pro);
Gau_pro = Gau_pro; 
% Calculate the peak amplitude of the propagated Gaussian beam
Peak_pro = max(max(abs(Gau_pro)));
sprintf('propagated peak amplitude is %f [mm]', Peak_pro)
%calculated beam width 
[N M]=min(abs(x));
Gau_pro1=Gau_pro(:,M);
[N1 M1]=min(abs(abs(Gau_pro1)-abs(exp(-1)*Peak_pro)));
Bw=dx*abs(M1-M)*10^3;
% Display the calculated beam width
sprintf('calculated beam width(numerical) is %f [mm]', Bw)
%theoretical beam width
W = (2*z_ray)/ko*(1 + (z/z_ray)^2);
W=(W^0.5)*10^3;
sprintf('theoretical beam width is %f [mm]', W)

%axis in mm scale
x=x*10^3;
y=y*10^3;

figure(1)
mesh(x,y,abs(Gau))
title('initial gaussian beam')
xlabel('x[mm]')
ylabel('y[mm]')
axis([min(x) max(x) min(y) max(y) 0 1])
axis square

figure(2);
mesh(x, y, abs(Gau_pro));
title('propagated gaussian beam');
xlabel('x[mm]');
ylabel('y[mm]');
axis([min(x) max(x) min(y) max(y) 0 1]);
axis square;