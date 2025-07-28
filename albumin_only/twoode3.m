function dydx = twoode3(x,y,region,IOP)
global_variables;

p = y(1); c2 = y(3); 

%a=1; % funciton for the locaiton of the cc
a = vessel_distribution(x); % function for the location of the cc

% equations
dydx(3) = y(4);

pb=IOP+dP;

switch region
    case 1    % x in [0 Lc] % choroid
        Q = Lp*(pb-p) - Lp*sigma*R*T*(c2b-c2); % net flux exchange with blood vessels
        b2 = betaa*(c2b-c2);
        
        dydx(1) = y(2)/Kc*mu;
        dydx(2) = -Q.*a;
        dydx(4) = 1/D2c*(-dydx(2).*c2-y(2)*y(4)-b2.*a);
    case 2    % x in [Lc Ls] % sclera
        dydx(1) = y(2)/Ks*mu;
        dydx(2) = 0;
        dydx(4) = 1/D2s*(-y(2)*y(4));
end








