%%
clear all; close all; clc;

%%
%This program to calculate polymer scaffold degradation was created by
%Renervate, KCL iGEM 2020
%%
%% MAIN SCRIPT
fprintf("This program is intended to help provide estimates about the\ndegradation of a PCL scaffold.\n\nThe following are the units of the data required for the estimate:\nMolecular weight: kDa\nDegradation Rate: Da/hour^-1\nTime: Hours\n\nUnit options can be found in Settings\nPlease select an option\n");

complete = false;
molwe = 'k';
degrt = 'h';
time = 'h';
T = 0;

while complete == false
    opt = input("Input-\n1 for Settings\n2 for Degradation prediction based on known degradation rate\n3 for Degradation prediction based on known porosity\n4 for Degradation based on time (calculating parameters based on a minimum scaffold time requirement) \n5 for the current units in use\nAny other number to end program\n");
    switch opt
        case 1
           [molwe, degrt, time] = settings(molwe, degrt, time); 
        case 2
            molecular_weight(molwe, degrt, time, T);
        case 3
            porosity(molwe, degrt, time, T);
        case 4
            time_degr(molwe, degrt, time);
        case 5
            disp(['Molecular weight is measured in ', molwe, 'Da']);
            disp(['Degradation rate is measured in ', degrt, '^-1']);
            disp(['Time is measured in ', time]);
        otherwise
            complete = true;
            break;
    end
end

%% SETTINGS
function [nwmolwe, nwdegrt, nwtime] = settings(molwe, degrt, time)
nwmolwe = molwe;
nwdegrt = degrt;
nwtime = time;
complete = false;
while complete == false
    opt = input('You have accessed the settings.\nHere you can change the units of the data required.\nPlese select\n1 to modify the unit of the molecular weight\n2 to modify the unit of the degradation rate\n3 to modify the unit of time\n');
    switch opt
        case 1
        disp(['Currently the molecular weight has a unit of ', molwe]);
        fprintf('d represents Daltons\nk represents kilo Daltons\n');
        dec = input('Please select one of the options of unit\n','s');
        if (dec == 'd') || (dec == 'k')
            nwmolwe = dec;
            disp(['The molecular weight is now measured in ', nwmolwe, 'Da']);
        else
            disp('Option not available');
        end
        case 2
        disp(['Currently the degradation rate has a unit of ', degrt, '-1']);
        fprintf('h represents Daltons per hour\nw represents Daltons per week\nm represents Daltons per month\n');
        dec = input('Please select one of the options of unit\n','s');
        if (dec == 'h') || (dec == 'w') || (dec == 'm')
            nwdegrt = dec;
            nwtime = dec;
            disp(['The degradation rate is now measured in ', nwdegrt, '^-1']);
            disp(['The time is now measured in ', nwtime]);
            disp(['Please note that the degradation rate is measured in DALTONS per ',nwdegrt]);
        else
            disp('Option not available');
        end
        case 3
        disp(['Currently the degradation rate has a unit of ', time, '^-1']);
        fprintf('h represents hours\nw represents weeks\nm represents months\n');
        dec = input('Please select one of the options of unit\n','s');
        if (dec == 'h') || (dec == 'w') || (dec == 'm')
            nwtime = dec;
            nwdegrt = dec;
            disp(['The time is now measured in ', nwtime]);
            disp(['The degradation rate is now measured in ', nwdegrt, '^-1']);
            disp(['Please note that the degradation rate is measured in DALTONS per ',nwdegrt]);
        else
            disp('Option not available');
        end
        otherwise
            disp('Option unavailable.');
            continue;
    end
    decision = input('Would you like to continue in settings? Input Y for yes or N for no.\n', 's');
    if (decision ~= 'Y') && (decision ~= 'y')
        complete = true;
    end
end
end
        
%% MOLECULAR WEIGHT & DEGRADATION RATE
function molecular_weight(molwe, degrt, time, T)
% k is the degradation rate constant, this value of k is obtained from
% literature but we will be using another script to obtain a more accurate
% value that uses porosity as a parameter. Can also make this an input from
% the user
% k = 9.65E-5; THIS IS OUR VALUE

%checking whether the user inputs a valid answer, if not the question will 
%be repeated
k = input(['Enter your degradation rate constant in ', degrt, '^-1: \n']);
general_formula(molwe, time, k, T);
end

%% POROSITY
function porosity(molwe, degrt, time, T)
disp('If the porosity of your material is known AND the material of interest is PCL (polycaprolactone),'); 
disp('the degradation rate may be calculated.');
%e is the porosity
e = input('Enter your porosity (as a decimal percentage, e.g. 50% = 0.5): \n');
k = calcRateOfDegradation(e, time); %uses the function to find k
%display the value of k to the user
fprintf(['The calculated degradation rate is: ', num2str(k), ' ', degrt, '^-1\n']);
general_formula(molwe, time, k, T);

end

%% calculate the rate of degradation based on porosity
function k = calcRateOfDegradation(e, time)
%Usage:
    %Input: e = porosity (%) between 0 < e < 1
    %Output: k = rate of degradation per hour of PCL (hour-1)
%Method: 
    %Calculates the rate of degradation of a PCL scaffold per hour dependent on
    %porosity (%) from https://doi.org/10.1016/j.polymdegradstab.2012.10.008
    %Eq 3-3 
    
    %Ensure that the porosity entered is within the acceptable range, if
    %not throw a warning dialogue
    if e > 1 || e < 0
        warndlg('Porosity outside of range. Please enter a value between 0 and 1 (e.g. 95% = 0.95) for correct results');
    end
    
    A = 1.85e-4; %fixed constant for PCL from Zhang et al
    B = 1.3e-2; %fixed constant for PCL
    k = ((A*e^3)/(1-e)^2)+B;  %rate of degradation in week-1
    
    switch time
    case 'h'
        k = k/168;        
    case 'm'
         k = k*((365/7)/12);
    end
    
end %function

%% DEGRADATION OVER TIME
function time_degr(molwe, degrt, time)
T = input(['Please enter the length of time required before the scaffold\nreaches its critical molecular weight in ', time, ':\n']);
unk = input('Select which is your unknown variable:\n1 for Degradation Rate\n2 for Initial Molecular Weight\n3 for both Degradation Rate and Initial Molecular Weight\n');
switch unk
    case 1
        porosity(molwe, degrt, time, T);
    case 2
        critMolWe = input(['Enter your critical molecular weight in ', molwe,'Da: \n']);
        k = input(['Please enter the degradation rate in ', degrt, '^-1:\n']);
        molweight = (critMolWe/(exp(-k*T)));
        disp(['A molecular weight of ', num2str(molweight), ' ', molwe, '^Da or above should ensure']);
        disp(['that the critical molecular weight is only reached after ', num2str(T), ' ', time]);
        stpsz = input('Please enter the step size (suggestion 500 for h, 3 for w and 0.5 for m):\n'); 
        if stpsz >= T
            error("Your step size is larger than your sample!");
        end
        t = 0:stpsz:T;
        molWeight = molweight * exp(-k*t);
        figure(1);
        hold on;
        plot(t,molWeight); % User can add more plots if they so desire using the plot function.
        hold off;
        xlabel(["Time ", time]);
        ylabel(["Molecular Weight ", molwe]);
        title("Simulation of Degradation of Molecular Weight Over Time Within a Scaffold");

    case 3
        e = input('Enter your porosity (as a decimal percentage, e.g. 50% = 0.5): \n');
        k = calcRateOfDegradation(e, time); %uses the function to find k
        critMolWe = input(['Enter your critical molecular weight in ', molwe,'Da: \n']);
        molweight = (critMolWe/(exp(-k*T)));
        disp(['The degradation rate based on your scaffold porosity is ', num2str(k), degrt '^-1']);
        disp(['A molecular weight of ', num2str(molweight), ' ', molwe, 'Da or above should ensure']);
        disp(['that the critical molecular weight is only reached after ', num2str(T), ' ', time]);
        stpsz = input('Please enter the step size (suggestion 500 for h, 3 for w and 0.5 for m):\n'); 
        if stpsz >= T
            error("Your step size is larger than your sample");
        end
        t = 0:stpsz:T;
        molWeight = molweight * exp(-k*t);
        figure(1);
        hold on;
        plot(t,molWeight); % User can add more plots if they so desire using the plot function.
        hold off;
        xlabel(["Time ", time]);
        ylabel(["Molecular Weight ", molwe, "Da"]);
        title("Model of the Degradation of Molecular Weight Over Time Within a Scaffold");
end 

end
%% GENERAL FORMULA
function general_formula(molwe, time, k, T)
initialMolWeight = input(['Enter your initial molecular weight in ', molwe,'Da : \n']); 
resp = 'Q'; %preallocating to a general value

% The critical molecular weight is obtained from literature, this can be
% adjusted at the user's discretion.

if T > 0
    critMolWeight = input(['Enter your critical molecular weight in ', molwe,'Da: \n']);
else
    resp = input('Would you like to add your critical molecular weight?\nInput Y for yes or N for no.\n', 's');
    if (resp == 'Y') || (resp == 'y')
        critMolWeight = input(['Enter your critical molecular weight in ', molwe,'Da: \n']);
        % do a if statement to check if the min value of the y values is less than
        % this if it is throw an error warning.

        if initialMolWeight < 0
            error("You have tried to enter a negative initial molecular weight!")
        end

        if critMolWeight < 0
            error("You have tried to enter a negative critical molecular weight!")
        end
    end
    length = input('Please enter the number of years to be simulated (suggestion; 2 years):\n');
    switch time
        case 'h'
            length = round(length*365*24);
        case 'w'
            length = round(length*(365/7));
        case 'm'
            length = round(length*12);
    end

end
if T > 0
    length = T;
end
stpsz = input('Please enter the step size (suggestion 500 for h, 3 for w and 0.5 for m):\n'); 
if stpsz >= length
    error("Your step size is larger than your sample");
end
t = 0:stpsz:length;
molWeight = initialMolWeight * exp(-k*t);

%if the molecular weight becomes lower than the critical, warn the user
if (resp == 'Y') || (resp == 'y') || (T > 0)
    if min(molWeight)<critMolWeight
        warndlg('WARNING! SCAFFOLD WILL DEGRADE BEYOND THE CRITICAL MOLECULAR WEIGHT IN THE GIVEN TIME PERIOD!')
        crit = find(molWeight<=critMolWeight);
        crit_t =crit(1)*stpsz;
        fprintf(['It would take the scaffold ', num2str(crit_t), ' (time in ', time, ')\nto reach its critical molecular weight\n']);
    elseif (T > 0) && (min(molWeight) > critMolWeight)
        warndlg('YOUR SCAFFOLD WILL NOT DEGRADE BEYOND THE CRITICAL MOLECULAR WEIGHT IN THE GIVEN TIME PERIOD!')
    end 
end

figure(1);
hold on;
plot(t,molWeight); % User can add more plots if they so desire using the plot function.
hold off;
xlabel(["Time ", time]);
ylabel(["Molecular Weight ", molwe, "Da"]);
title("Simulation of the Degradation of Molecular Weight Over Time Within a Scaffold");
end

