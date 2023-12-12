function f = fTriangle(t)
%% 1 - Sommets
A = 3;
B = 4i;
C = 0;

%% 2 - Cotes
if and(t >= 0, t < 2*pi/3)
    T = t/(2*pi/3);
    f = (1-T)*A + T*B;
    

elseif and(t >= 2*pi/3, t < 4*pi/3)
    T = (t-2*pi/3)/(2*pi/3);
    f = (1-T)*B + T*C;

elseif and(t >= 4*pi/3, t <= 2*pi )  
    T = (t-4*pi/3)/(2*pi/3);
    f = (1-T)*C + T*A;
end