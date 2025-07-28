% Parameter values for mice %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% thermodynamics
R = 8.314; %gas constant
T = 37+273;% K, temperature

% diffusion in the choroid
D2c = 8.75e-11; % (m^2/s) diffusion coefficient for albumin 
D3c = D2c; % 

% diffusion in the sclera
D2s = 9.6e-12; % (m^2/s) diffusion coefficient for albumin Anderson 2007
D3s = D2s;

% geometry
Lc=30e-6; %  (m) thickness of the choroid in mice
Ls = 70e-6; % (m) thickness of the sclera in mice range: 36-100 um
R_eye=.17e-2; % (m) radius of the eye
Surf_A = 2*pi*(R_eye)^2*(1-cos(140/180*pi)); % (m^2) surface area of the choroid
cf=9e-6/Lc; % fraction of the vessels 9 mu m of thickness of the choriocapillaris

% fluids
mu = 0.7e-3; % (Pa*s) fluid viscosity
Ks = 9.2e-15*mu; % From Ross' measurements on mouse sclera
Kc = Ks*100;

qrpe = (23)*1e-8; % (m/s) flow through RPE from our 2020 paper
p0 = 3*133; % (Pa) pressure in orbit 
dP = 5*133; % (Pa) pressure in the blood -IOP
Deltap = 1*133; % (Pa) pressure drop between IOP and choroid

Lp = 3.56e-05; % (1/s/Pa) conductance art cap, optimal value weights (1,1,0,1)

% permeability to albumin
betaa =0.00137; % (1/s) permeability of art cap to albumin, optimal value (1,1,0,1) (with dP=5mmHg)
% concentrations
albuminmw = 66.4303; % (kg/mol) molecular weight of albumin
c2b = 27/albuminmw; % (mM equiv 0.001 mol/L equiv mol/m^3) arterial albumin
c2b_fixed = c2b; % (mM equiv 0.001 mol/L equiv mol/m^3) arterial albumin

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

Qprod = 48e-12/60; % (m^3/s) rate of aqueous production
Pev = 7.5*133; % (Pa) pressure in the episcleral veins
C = 5.89e-12/60/133; % (m^3/s/Pa) facility of TM

sigma =  1; % reflection coefficient

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% target values for optimisation

IOP_e = 14.4*133;
c_alb_e = c2b*0.19; %
alb_prod_e = 3.21e-12;
Q_ratio_e = 0.2;
