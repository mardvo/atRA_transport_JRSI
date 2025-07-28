% Parameter values for humans %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% thermodynamics
R = 8.314; % (J / mol·K) gas constant
T = 37+273;% (K) temperature

% diffusion in the choroid
D2c = 8.75e-11; % (m^2/s) diffusion coefficient for albumin 
D3c = D2c; % 

% diffusion in the sclera
D2s = 9.6e-12; % (m^2/s) diffusion coefficient for albumin Anderson 2007
D3s = D2s;

% geometry
Lc=268e-6; % (m) thickness of human Jen's paper
Ls = 670e-6; % (m) thickness of the sclera Jen's paper
R_eye=1.15e-2; % (m) radius of the eye
Surf_A = 2*pi*(R_eye)^2*(1-cos(140/180*pi)); % (m^2) surface area of the choroid
cf=9e-6/Lc; % fraction of the vessels 9 mu m of thickness of the choriocapillaris

% fluids
mu = 0.7e-3; % (Pa*s) fluid viscosity
Ks = 1.33e-18;
Kc = Ks*100;

qrpe = 3e-8; % (m/s) flow through RPE from our 2020 paper (3 acc)
%qrpe = 1.1e-8; % (m/s) flow through RPE from our 2020 paper (3 acc)
p0 = 3*133; % (Pa) pressure in orbit 
dP = 5*133; % (Pa) pressure in the blood - IOP
Deltap = 1*133; % (Pa) pressure drop between IOP and choroid

Lp = 1.8323e-07;  % (1/s/Pa), opt for weight (1,1,0,1) cost 0.025

% concentrations
albuminmw = 66.4303; % (kg/mol) molecular weight of albumin
c2b = 45.5/albuminmw; % (mM equiv 0.001 mol/L equiv mol/m^3) arterial albumin
c2b_fixed = c2b; % (mM equiv 0.001 mol/L equiv mol/m^3) arterial albumin

% permeability to albumin

betaa =3.3968e-06; % weight (1,1,0,1)  and (1,1,0,1)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

Qprod = 2.53e-9/60; % (m^3/s) rate of aqueous production
Pev = 7.1*133; % (Pa) pressure in the episcleral veins
C = 0.26e-9/60/133; % (m^3/s/Pa) facility of TM

sigma =  1; % reflection coefficient

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% target values for optimisation

IOP_e = 14.9*133;
c_alb_e = c2b*0.19;
alb_prod_e = 4.17e-13; % in mol/s 
Q_ratio_e = 0.2;