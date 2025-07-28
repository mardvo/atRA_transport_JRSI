%% PARAMETER INITIALIZATION
% set up max and mix matrices
species = 1;
if species == 1
    disp('Parameters set for human')
    disp(' ');
    parameters_h; % call the parameter file for human
elseif species == 2
    disp('Parameters set for mouse')
    disp(' ');
    parameters_m; % call the parameter file for mouse
else
    disp('No parameters set')
    return;
end
pmean = [Ks,% Ks
    Lp, % Lp
    betaa, % betaa
    qrpe, % qrpe
    dP, % pressure difference with blood
    Deltap, % pressure difference with IOP
    1];
% min values
pmin = [Ks/2,% Ks
    Lp/3, % Lp
    betaa/3, % betaa
    qrpe*0.5, % qrpe
    3*133, % pressure difference with blood
    0*133, % pressure difference with IOP
    0];
% max values
pmax = [Ks*1.5,% Ks
    Lp*3, % Lp
    betaa*3, % betaa
    qrpe*1.5, % qrpe
    7*133,% pressure difference with blood
    2*133,% pressure difference with IOP
    10];

% Parameter Labels
efast_var={'Ks','Lp','beta','qrpe','dP','deltaP','dummy'};%,

% PARAMETER BASELINE VALUES (in terms of mean values)

y0=1:6;

% Variables Labels
y_var_label={'IOP','Q_ves','vel','Qu','c_alb','Alb_leak'};

