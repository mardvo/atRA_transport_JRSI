%%% Optimisation problem 
% Optimises the values of the parameters Lp and betaa
close all
clear all;
TopFolder = fileparts(pwd);
addpath(TopFolder+"/parameters/");
global_variables;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% choice between human (1) or mouse (2) parameters
species = 2;
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

feeding =0; 
parameters_atra;
%pp = fmincon(@cost_fun_atra1,[k2],[],[],[],[],[k2/3],[k2*3]);
pp = fmincon(@cost_fun_atra1,[atra_prod],[],[],[],[],[atra_prod/5],[atra_prod*5]);

k2=pp(1);



