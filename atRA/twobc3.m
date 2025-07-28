function res = twobc3(ya,yb,IOP)
% ya = 0 condizione in the left end
% yb = 0 condizione in the right end
% second dimension represents choroid (1) or sclera (2)

global_variables;

Qu = -((IOP-Pev)*C-Qprod);
Q0 = Qu/Surf_A;

res = [-ya(2,1)-qrpe % prescribed flux though RPE
    -D2c*ya(4,1)-ya(2,1).*ya(3,1) % zero flux of albumin
    -D3c*ya(6,1) - ya(2,1).*ya(5,1) % zero flux of albumin_A
    yb(2,1)-ya(2,2)-Q0 % continuity of flux
    yb(1,1)-ya(1,2) % continuity of pressure
    yb(3,1)-ya(3,2) % cont. of c2
    yb(5,1)-ya(5,2) % cont of c3
    yb(2,1)*yb(3,1)+D2c*yb(4,1) - (ya(2,2)*ya(3,2)+D2s*ya(4,2)) % cont of c2 flux
    yb(2,1)*yb(5,1)+D3c*yb(6,1) - (ya(2,2)*ya(5,2)+D3s*ya(6,2)) % cont of c3 flux
    yb(1,2)-p0 % p0 pressure at the orbit
    %yb(3,2)-c2o; % prescribed c2o at the orbit
    yb(4,2) % zero SA diffusive flux at the orbit
    %yb(5,2); % prescribed atRASA concentratiom to 0 at the orbit
    yb(6,2)  % zero atRASA diffusive flux at the orbit
    yb(1,1)-(IOP-Deltap)]; % Prescribed Delta P between IOP and suprachoroidal space
    %ya(1,1)-(IOP-Qu*R_cm)]; % Prescribed Resistance of the ciliary muscle
    %IOP-Pev-(Qprod-Qu)/C]; % Set IOP-p(0)
