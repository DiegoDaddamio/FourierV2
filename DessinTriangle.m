close all;
clear;
clc;

%% 1 - Parametres
%% 1.1 - Nombres d'epicycles
N = 15;
if rem(N,2) == 0
    N = N+1; % Correction si N est pair
end
n = -(N-1)/2:(N-1)/2;

%% 1.2 - Taux d'echantillonnage
h = 0.001; 

%% 2 - Echantillonnage de fCarre
x = 0:h:2*pi;

L = length(x);
f = zeros(1,L);
cpt = 1;
for p = x
    f(cpt) = fTriangle(p);
    cpt = cpt + 1;
end

%% 3 - Calcul des coefficients de Fourier
expo = zeros(N,L);
c = zeros(1,N);
for k = 1:N
    expo(k,:) = exp(1i*n(k)*x);
    c(k) = trapz(x,f.*expo(k,:))/(2*pi);
end

dessinSF = c*expo;

%% 4 - Trace des dessins
plot(real(f),imag(f),'b','LineWidth',2);
hold on;
plot(real(dessinSF),imag(dessinSF),'m-.','LineWidth',2);
legend('Original',['Dessin par SF (N = ',num2str(N),')']);
