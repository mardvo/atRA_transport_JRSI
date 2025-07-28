function res = twobc3(ya,yb,IOP)

% ya = 0 condizione in the left end
% yb = 0 condizione in the right end
% second dimension represents choroid (1) or sclera (2)
global_variables;

Qu = -((IOP-Pev)*C-Qprod);
Q0 = Qu/Surf_A;

res = [-ya(2,1)-qrpe % prescribed flux though RPE
    -D2c*ya(4,1)-ya(2,1).*ya(3,1) % zero flux of albumin
    yb(2,1)-ya(2,2)-Q0 % continuity of pressure derivative
    yb(1,1)-ya(1,2) % continuity of pressure
    yb(3,1)-ya(3,2) % cont. of c2
    yb(2,1)*yb(3,1)+D2c*yb(4,1) - (ya(2,2)*ya(3,2)+D2s*ya(4,2)) % cont of c2 flux
    yb(1,2)-p0 % p0 pressure at the orbit
    %yb(3,2)-c2o]; % prescribed c2o
    yb(4,2)
    yb(1,1)-(IOP-Deltap)]; 
    %IOP-Pev-(Qprod-Qu)/C]; % Set IOP-p(0)


