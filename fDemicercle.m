function f = fDemicercle(t)

%% 1 - Parametres
coinBasDroite = 1;
coinBasGauche = -1;

%% 3 - Cotes
if and(t >= 0, t < pi)
    f = exp(1i*t);

elseif and(t >= pi, t <= 2*pi )  
    T = (t-pi)/(pi);
    f = (1-T)*coinBasGauche + T*coinBasDroite;
end