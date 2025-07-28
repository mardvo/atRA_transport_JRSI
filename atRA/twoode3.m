function dydx = twoode3(x,y,region,IOP)

global_variables;

p = y(1); % pressure
c2 = y(3); % SA concentration
c3 = y(5); % atRASA concentration

a = vessel_distribution(x); % function for the location of the cc

% equations
dydx(3) = y(4);
dydx(5) = y(6);

pb=IOP+dP;

switch region
    case 1    % x in [0 Lc] % choroid
        q2=-atra_prod;
        q3=atra_prod;
        Q = Lp*(pb-p) - Lp*sigma*R*T*(c2b-c2) - Lp*sigma*R*T*(c3b-c3); % net flux exchange with blood vessels
        b2 = betaa*(c2b-c2);
        b3 = betaa*(c3b-c3);

        dydx(1) = y(2)/Kc*mu;
        dydx(2) = -Q.*a;
        dydx(4) = 1/D2c*(-dydx(2).*c2-y(2)*y(4)-(q2+b2).*a);
        dydx(6) = 1/D3c*(-dydx(2).*c3-y(2).*y(6)-(q3+b3).*a);
    case 2    % x in [Lc Ls] % sclera
        %q2=(VmCyP26A1*c3)/(KmCyP26A1+c3);
            %+VmCyP26B1*c3/(KmCyP26B1+c3));
        %*(Indm*c3/(Ind50+c3))
%        q2=k2*c3; % Masha's original approach
        q2=k2*c3*(Ind_max*(c3/fu_inc)/((c3/fu_inc)+Ind_C50)); % This includes induction of the reaction (from )
        q3=-q2;
        dydx(1) = y(2)/Ks*mu;
        dydx(2) = 0;
        dydx(4) = -1/D2s*(y(2)*y(4)+q2);
        dydx(6) = -1/D3s*(y(2).*y(6)+q3);
end
