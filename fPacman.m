function f = fPacman(t)

%% 1 - Parametres
anglesup = exp(1i*pi/12);
angleinf = exp(1i*-pi/12);

%% 3 - Cotes
if and(t >= 0, t < 2*pi/3)
    T = t/(2*pi/3);
    f = exp(1i*T*11*pi/6)*anglesup;

elseif and(t >= 2*pi/3, t < 4*pi/3)
    T = (t-2*pi/3)/(2*pi/3);
    f = (1-T)*angleinf;

elseif and(t >= 4*pi/3, t <= 2*pi )  
    T = (t-4*pi/3)/(2*pi/3);
    f = T*anglesup;
end