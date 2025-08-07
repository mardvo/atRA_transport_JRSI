List of the files with explanations

1) main.m runs the model and produces figure 2, 3. It uses function solve_model3.m, which solves ODES in file twoode3.m with boundary conditions in file twobc3.m

2) opt_pars.m performs optimisation procedure to find L_p and beta using cost_fun.m as a cost function.

3) var_beta_Lp.m makes parameter span for parameters beta and Lp.

4) Folder Sensitivity analysis contains codes for running sensitivity analysis and producing figure 4.
