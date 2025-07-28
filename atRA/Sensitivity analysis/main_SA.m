clear;
close all;

TopFolder = fileparts(pwd);
addpath(TopFolder);
TopTopFolder = fileparts(TopFolder);
addpath(TopTopFolder+"/parameters");

global_variables;

Parameter_settings_EFAST; % call parameter file

if species == 1
    disp('Parameters set for human')
    disp(' ');
    load('X_h.mat');
elseif species == 2
    disp('Parameters set for mouse')
    disp(' ');
    load('X_m.mat');
else
    disp('No parameters set')
    return;
end

Y(NS,length(y0),length(pmin),NR)=0;  % pre-allocation

for i=1:k
    for Ll=1:NR
        for run_num=1:NS            
            [i run_num Ll] % keeps track of [parameter run NR]
            % run the model
            [IOP,Qleak,Alb_leak,vel,Qu,c_alb,tot_atra,atra_S] = model(X(run_num,:,i,Ll));
            % It saves only the desired output
            Y(run_num,:,i,Ll)=[IOP,Qleak,vel,Qu,c_alb,Alb_leak,tot_atra,atra_S]; % this is the output 
        save("res.mat")
        end %run_num=1:NS
    end % L=1:NR
end

save res.mat;
exit
