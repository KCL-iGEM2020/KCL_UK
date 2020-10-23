# Renervate Scaffold Degradation Simulator
This code allows for the simulation of degradation of a polymer scaffold over a specified time frame. We have made this program easy to follow, with all of the customisation features and inputs added at run time rather than 'hard-coded'. Simply, the program may be run and then the parameters are given in the MATLAB comamand window. From here, the program will predict the degradation for each time point, t. The interval of which t is calculated may also be given to the code at run time; although, note that a greater number of time calculations will be at computational expense.

## Porosity
This program has the ability to predict a scaffold's degradation if a porosity value is inputted, however this is only suited to PCL (polycaprolactone). This can be changed, however, by altering the <i> k = calcRateOfDegradation(e, time) </i> function, beginning on line 122 - the inputs and outputs are explained within the comments following this. Specifically, line 139: 
~~~
k = ((A*e^3)/(1-e)^2)+B; 
~~~

details the relationship between k (the degradation rate), e (the porosity) and constants A, B determined experimentally by (Zhang et al., 2013) for PCL. Altering the mathematical relation for k for another polymer would allow for the code to run the same as currently intended.

## Degradation Rate
Although the porosity degradation rate is hard-coded, a known degradation rate may be entered instead - assuming that a polymer that undergoes bulk erosion is considered. This means that the code extends beyond PCL alone.

# References
Zhang, Q., Jiang, Y., Zhang, Y., Ye, Z., Tan, W. and Lang, M., 2013. Effect of porosity on long-term degradation of poly (ε-caprolactone) scaffolds and their cellular response. Polymer Degradation and Stability, 98(1), pp.209-218.

<i>If any clarification of the code is required, do not hesitate to contact us via any of the social links found in our wiki footer [here](https://2020.igem.org/Team:KCL_UK/Degradation_Model)</i>
