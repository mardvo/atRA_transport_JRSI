%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% aTRA paramaters


atra_prod =  7.798e-08; % % mM/s atRA production rate 

k2 = 3.505e-04;% % Unbinding constant (atRASA -> atRA + SA) atRA is lost in the cell (value optimised for the feeding case)

Ind_max = 33;
Ind_C50 = 9e-5;
fu_inc = 0.4;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% concentratioin in the serum

if feeding == 0&&species==2
    c3b = 1.25e-6; % (mM) concentration of atRA+alb in serum (physiological conditions from Ross's measurements)
    c2b = c2b-c3b; 
elseif feeding == 1&&species==2
    c3b = 11.67e-3; % (mM) concentration of atRA+alb in serum (feeding value from Ross's measurements)
    c2b = c2b-c3b;
elseif species == 1
    c3b=2.5e-6;
    c2b = c2b-c3b; 
    atra_prod =  atra_prod*0.1300; 
    k2 = k2*0.1300;
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% target values for optimisation

c3_exp_nf = 0.68e-5*1.1;  % non feeding
c3_exp_f = 0.62e-3*1.1;  % feeding
