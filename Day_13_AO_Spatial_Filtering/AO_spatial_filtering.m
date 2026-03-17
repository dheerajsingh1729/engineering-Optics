% AO_spatial_filtering_corrected.m
clear
Q=input('Q= ');
z=1;
Ld=input('Wavelength of sound wave in [mm] (0.1 mm nominal value)= ');
Ld=Ld*10^-3;
al=input('alpha = ');
X_Sx=input('Length of square in [mm] (enter 1-3)= ');
X_Sx=X_Sx*10^-3;

Xmin=-0.005;
Xmax=0.005;
Step_s=0.5*6.5308e-005;
x=Xmin:Step_s:Xmax;

% Length of consideration range
L=Xmax-Xmin;

% Ratio of square
R=X_Sx/L;

n=size(x);
N=n(2);

% Square size
Sx=round(N*R);

% Create square aperture
Einc=zeros(N,N);
Einc(round(N/2)-round(Sx/2):round(N/2)+round(Sx/2), ...
     round(N/2)-round(Sx/2):round(N/2)+round(Sx/2)) = 1;

% FFT of input
F_Einc=fftshift(fft2(Einc));

% dx
dx=L/(N-1);

% Space and frequency axes
for k=1:N
    X(k)=L/N*(k-1)-L/2;
    Y(k)=L/N*(k-1)-L/2;

    Kxp(k)=(2*pi*(k-1))/((N-1)*dx);
    Kyp(k)=(2*pi*(k-1))/((N-1)*dx);
end

Kx=Kxp-max(Kxp)/2;
Ky=Kyp-max(Kyp)/2;

% ----------- CORRECT H0 -----------
H0=zeros(N,N);
for l=1:N
    for m=1:N
        d_x = Kx(m);   % FIXED (removed wrong scaling)

        beta = sqrt((d_x*Q/4)^2 + (al/2)^2);
        A = cos(beta*z);
        B = sin(beta*z)/beta;

        H0(l,m) = exp(-1i*d_x*Q*z/4)*(A + 1i*d_x*Q/4*B);
    end
end

% ----------- APPLY FILTER -----------
F_Eout_zero = F_Einc .* H0;

% Inverse FFT
E_out_zero = ifft2(ifftshift(F_Eout_zero));

% Scale axes to mm
X = X*10^3;
Y = Y*10^3;
Kx = Kx*10^-3;
Ky = Ky*10^-3;

% ----------- PLOTS -----------

figure(1)
plot(Kx,abs(H0(round(N/2),:)))
title('Magnitude of transfer function H0')
xlabel('Kx [rad/mm]')
grid on
axis([min(Kx) max(Kx) 0 1])
axis square

figure(2)
imagesc(X,Y,abs(Einc))
colormap(gray(256))
title('Profile of incident beam')
xlabel('x [mm]')
ylabel('y [mm]')
axis square

figure(3)
imagesc(X,Y,abs(E_out_zero)/max(max(abs(E_out_zero))))
colormap(gray(256))
title('Profile of zeroth-order output beam')
xlabel('x [mm]')
ylabel('y [mm]')
axis square