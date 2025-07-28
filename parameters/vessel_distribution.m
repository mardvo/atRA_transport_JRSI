function a = vessel_distribution(x)
global species Lc
global cf cs

%global_variables;

if species == 1
    
    cs=100;
    a = (1-1./(1+exp(-cs*(x-Lc*cf)/Lc)))/cf; % for human
else
    
    cs=100;
    a = (1-1./(1+exp(-cs*(x-Lc*cf)/Lc)))/cf; % for mouse
%    a = 1+0.*x; % for mouse
end
