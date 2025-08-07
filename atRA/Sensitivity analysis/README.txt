The codes are adapted from 

Marino S, Hogue IB, Ray CJ, Kirschner DE. A methodology for performing global uncertainty and sensitivity analysis in systems biology. J Theor Biol. 2008 Sep 7;254(1):178-96. doi: 10.1016/j.jtbi.2008.04.011. Epub 2008 Apr 20. PMID: 18572196; PMCID: PMC2570191.

Their codes can be found on the website http://malthus.micro.med.umich.edu/lab/usadata/ 


List of the files with explanations

1) Set the parameters

Parameter_settings_EFAST

Sets all the parameters in the model, including those you want to span. 
pmean - is the mean value of the parameters
pmin - minimum value
pmax - maximum value

selectX - spans parameters with given frequencies and saves them into the variable X and the file X.mat

it uses functions SETFREQ.m to set the frequencies and parameterdist.m to set distribution of the parameters (can pick between uniform, normal or lognormal)

2) Run your solver for parameters from X.mat

- this is the file main_SA.m, which calls the function model.m 
The outpout is stored in variable Y. You can pick multiple outputs, like various concentrations, consumptions, etc

To make things quicker you can run in parallel for each parameter (variable i=1:k)

3) Analyse the results

Once you have your output Y, you can analyse it. Analysis scripts are in folder 'analysis'. Here res.mat is the result and X.mat is the parameter file. In this code, the results for mouse in feeding and non-feeding conditions and human are in different folders: 'm_f_27_01', 'm_nf_27_01' and 'h_27_01', respectively. 

To run SA, you can use results.m file. It produces bar plots with sensitivity indices for figure 7. These indices are calculated by function efast_sd_2.m 

A script that takes care of NANs if there are any is interp_nonan.m 

Finally, to get scatter plots to assess the direction of change for each parameter, run script some_plots.m