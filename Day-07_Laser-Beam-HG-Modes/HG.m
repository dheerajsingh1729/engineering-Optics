% HG.m (Plotting Hermite-Gaussians up to m=n=3 mode)
clear;
clc;

% Input modes
m = input('m (enter between 0 to 3) = ');
n_mode = input('n (enter between 0 to 3) = '); % Renamed from 'n' to avoid conflict

% Constants and Grid Setup
ko_d = 1;
Xmin = -5; 
Xmax = 5;
% Note: Step_s in the book is very small. Increased slightly for performance.
Step_s = 0.05; 
x = Xmin:Step_s:Xmax;
y = x;

% --- Calculate Hermite Polynomial for m (x-direction) ---
if m == 0, Hm = ones(size(x)); end
if m == 1, Hm = 2*x*ko_d; end
if m == 2, Hm = 4*x.^2 - 2*ones(size(x)); end
if m == 3, Hm = 8*x.^3 - 12*x; end

% --- Calculate Hermite Polynomial for n (y-direction) ---
if n_mode == 0, Hn = ones(size(y)); end
if n_mode == 1, Hn = 2*y*ko_d; end
if n_mode == 2, Hn = 4*y.^2 - 2*ones(size(y)); end
if n_mode == 3, Hn = 8*y.^3 - 12*y; end

% --- Generate the 2D Field ---
N = length(x);
psy = zeros(N, N); % Pre-allocate matrix for speed

for k = 1:N
    for l = 1:N
        % Gaussian Term * Hermite(x) * Hermite(y) * Phase Term
        % Fixed indexing: Hm uses 'l' and Hn uses 'k'
        term1 = exp(1i * ko_d/2 * (x(l)^2 + y(k)^2));
        term2 = Hm(l) * Hn(k);
        term3 = exp(-ko_d/2 * (x(l)^2 + y(k)^2));
        
        psy(k,l) = term1 * term2 * term3;
    end
end

% --- Plotting ---
figure(1)
% Use imagesc for better scaling than the basic 'image' command
intensity = abs(psy).^2;
imagesc(x, y, intensity)
colormap(gray(256))
title(['Hermite-Gaussian Mode (m=', num2str(m), ', n=', num2str(n_mode), ')'])
xlabel('x [mm]')
ylabel('y [mm]')
axis square
colorbar; % Adds a scale to see intensity levels