function f = fCarre(t)

%% 1 - Parametres
coinBasGauche = -1 - 1i;
longueurCote = 2;

%% 2 - Sommets
coinBasDroite = coinBasGauche + longueurCote;
coinHautDroite = coinBasDroite + longueurCote*1i;
coinHautGauche = coinHautDroite - longueurCote;

%% 3 - Cotes
if and(t >= 0, t < pi/2)
    T = t/(pi/2);
    f = (1-T)*coinBasGauche + T*coinBasDroite;

elseif and(t >= pi/2, t < pi)
    T = (t-pi/2)/(pi/2);
    f = (1-T)*coinBasDroite + T*coinHautDroite;

elseif and(t >= pi, t < 3*pi/2)
    T = (t-pi)/(pi/2);
    f = (1-T)*coinHautDroite + T*coinHautGauche;

elseif and(t >= 3*pi/2, t <= 2*pi )  
    T = (t-3*pi/2)/(pi/2);
    f = (1-T)*coinHautGauche + T*coinBasGauche;
end