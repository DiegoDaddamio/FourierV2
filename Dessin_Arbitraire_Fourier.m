%Le programme utilise deux Toolbox et une fonction externe:
%   -Image Processing Toolbox (par MathWorks)
%       Ici, sert à échantillonner le contour d'une forme sous format image
%   -gif (par Chad Greene)
%       Sert à générer un gif à partir d'une figure
%       Celle-ci est disponible en annexe

%% Import et traitement de l'image pour obtenir son contour
image = imread('bird.png');
gray = rgb2gray(image);
thresholded = gray > 128;
contours = bwboundaries(thresholded);
coordonates = cell2mat(contours);

%% Traitement des coordonnées
% Symétrie des coordonnées pour la rendre droite
coordonates(:,1) = coordonates(:,1)*-1;

% Centré en (0,0)
barricentre(1) = sum(coordonates(:,1))/length(coordonates(:,1));
barricentre(2) = sum(coordonates(:,2))/length(coordonates(:,2));
coordonates(:,1) = coordonates(:,1) - barricentre(1);
coordonates(:,2) = coordonates(:,2) - barricentre(2);

% Conclusion dans R²
x = coordonates(:,2);
y = coordonates(:,1);

% Passage au plan complexe
u = x + 1i*y;

%% Calcul des C_k
% Réorganisation pour avoir une période en 2pi en partant de 0
h = linspace(0,2*pi,length(x));
% Nombres d'épicycles
N = 121;
if rem(N,2) == 0
    N = N+1; % Correction si N est pair
end
% Vecteur des coéefficent k (pour accéder aux entiers négatifs)
n = -(N-1)/2:(N-1)/2;
% Initialisation des tableaux utilisés
expo = zeros(N,length(x));
c = zeros(1,N);

for k = 1:N
    % Calcul les facteurs e^(ikx) pour son utilisation dans l'approximation
    % de l'intégrale par des trapèzes
    expo(k,:) = exp(1i*n(k)*h);
    % Calcul des c_k via l'approximation aux trapèzes
    c(k) = trapz(h,((u).').*expo(k,:))/(2*pi);
end
% Report de tous les complexes, ici donnés par un produit matriciel (somme des c_k*e^ik)
SerieFourier = c*expo;

%% Visualisation de la série et de son original
% Superposition des deux
figure("Name","Superposition des deux")
hold on
plot(x,y,'b','LineWidth',2);
plot(real(SerieFourier),imag(SerieFourier),'m-.','LineWidth',2);
legend('Original',['Dessin par SF (N = ',num2str(N),')']);
set(gca,'Xlim',[min(min(x),min(y))-10,max(max(x),max(y))+10],'Ylim',[min(min(x),min(y))-10,max(max(x),max(y))+10])
%% Epicycles
% Mise en ordre des facteurs k et des différents c(k)
order = zeros(N,1);
order(1) = 0;
counter = 1;
for i = 1: ((N-1)/2)
    for j = [1,-1]
        counter = counter + 1;
        order(counter)=(i*j);
    end
end
c_ordered = zeros(N,1);
c_ordered(1) = c((N-1)/2);
for i = 2: N
    c_ordered(i) = c(((N-1)/2)+order(i)+1);
end

% échantillon de l'interval [0,2pi]
x_ = linspace(0,2*pi,300);

% Initialisation des point tracé de la sommes des vecteurs 
pointdraw = zeros(1,2);

% Figure pour les épicycles
figure("Name","Epicycles")
%Création d'un gif
GIF_ON = false;
if upper(input('Creat a gif ? [Y/N] ','s')) == 'Y'
    %Nom du gif et initialisation
    %Utilisation de la Toolbox gif de Chad Greene
        gif('Rorating_vectors.gif','DelayTime',1/35)
        GIF_ON = true;
end


% Mise en mouvement des vecteurs tournants
for k = 1:length(x_)
    % Utilisation des vecteurs ordonnés
    o = exp(x_(k)*order*1i);
    o = o.*c_ordered;
    realx = real(o);
    imx = imag(o);
    realx(1) = 0;
    imx(1)= 0;

    % éditions des points initiaux des vecteurs (partie réelle
    startrealx = realx;
    startimx = imx;
    for i = 2:length(realx)
        startrealx(i) = sum(realx(1:i-1));
        startimx(i) = sum(imx(1:i-1));
    end
    startrealx(1) = 0;
    startimx(1) = 0;

    % Visualisation des vecteurs avec les points de la période [0,2pi]
    hold off
    quiver(startrealx,startimx,realx,imx,'off','filled',"black")
    hold on
    % Calcul des points à afficher
    pointdraw(k,:) = [startrealx(length(startrealx))+realx(length(realx)),startimx(length(startimx))+imx(length(imx))];
    scatter(pointdraw(:,1),pointdraw(:,2),10,"filled","red");
    plot(pointdraw(:,1),pointdraw(:,2));
    set(gca,'Xlim',[min(min(x),min(y))-10,max(max(x),max(y))+10],'Ylim',[min(min(x),min(y))-10,max(max(x),max(y))+10])
    if GIF_ON == true
        %"Enrengistrement" du gif
        %Utilisation de la Toolbox gif de Chad Greene
            gif
    end
    drawnow
end
