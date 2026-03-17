%P_sinc.m Plotting of sinc^2(x) function
x=-3.5:0.01:3.5;
Sinc=sin(pi*x)./(pi*x);
plot(x,Sinc.*conj(Sinc))
axis([-3.5 3.5 -0.1 1.1])
grid on