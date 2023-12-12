clear all
% Charger l'image
image = imread('music.png');

% Convertir l'image en niveaux de gris
gray = rgb2gray(image);

% Appliquer un seuillage pour obtenir une image binaire
thresholded = gray > 128;

% Trouver les contours dans l'image binaire
contours = bwboundaries(thresholded);

% Extraire les coordonnées des contours
coordinates = cell2mat(contours);

coordinates = coordinates*-1;
barricentre(1) = sum(coordinates(:,1))/length(coordinates(:,1));
barricentre(2) = sum(coordinates(:,2))/length(coordinates(:,2));

coordinates(:,1) = coordinates(:,1) - barricentre(1);
coordinates(:,2) = coordinates(:,2) - barricentre(2);
barricentre(1) = sum(coordinates(:,1))/length(coordinates(:,1));
barricentre(2) = sum(coordinates(:,2))/length(coordinates(:,2));

x = coordinates(:,2);
y = coordinates(:,1);
u = x+1i*y;

hold on;
scatter(x,y,5,"filled")
scatter(barricentre(2),barricentre(1),5,"filled")
hold off;

l = 101;

x(:,2) = linspace(0,2*pi,length(x));
c = zeros(l,1);
f = zeros(l,1);
n = -(l-1)/2:(l-1)/2;
expo = zeros(l,length(x(:,2)));

for k = 1 : l
    expo(k,:) = exp(1i*n(k)*x(:,2));
    c(k) = trapz(x(:,2),x(:,1).*exp(1i*n(k)*x(:,2)))/(2*pi);
end


dessinSF = (c.')*expo;

plot(dessinSF,'m-.','LineWidth',2);



