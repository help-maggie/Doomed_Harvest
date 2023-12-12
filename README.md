# Industry-Collapse

This README provides an overview of the Industry Collapse model, which simulates the dynamics of a population system involving humans and fish, considering fishing effort, catchability, and expected values of switching states based on the number of contacts.. The model is implemented in MATLAB and utilizes Ordinary Differential Equations (ODEs) to represent the interactions and changes over time.

# Initial Population Numbers
The initial population numbers are set as follows:

Initial total population (x_0): 100,000

Initial fish population (N_0): 500

Initial non-stressed humans (S_0): 0

Initial recovered humans (R_0): 0

These values are used to create the initial conditions for the simulation.

# Solving ODE
The model solves the system of ODEs using MATLAB's ode45 function, calling the ode_system2_2 function. The time span is set from 0 to 1000.

# ode_system2_2 function

## Parameters
t: Time variable.
y: State vector containing the variables describing the system.

## Overview
The function ode_system2_2 implements the ODE system that governs the evolution of the population system. It incorporates fishing effort options, catchability, and various options for fish population dynamics.

## Fishing Effort Options
The fishing effort (E) is defined based on the selected option. Make sure the correct number of inputs matches in the E() input of dxdt(1) in line 102.

## Fish Population ODE Options
Different options for modeling fish population dynamics are available.

## Expected Values of Switching State
Functions for calculating the expected values of switching state based on the number of contacts are defined:

gammaP_N(N)
betaP_S(S)
psiP_R(R)
deltaP_S(S)

## ODE System
The ODE system is defined with four equations representing the fish population and different human populations (non-stressed, stressed, and recovered).

dydt(1) = dxdt(y(1), E(y(2), y(3), y(1))); % Fish population ODE

dydt(2) = ((r_3 * y(1) / K) + gammaP_N(y(2))) * y(3) - ((r_1 * (K - y(1)) / K) + betaP_S(y(3)) + deltaP_S(y(3))) * y(2); % Non-stressed population ODE

dydt(3) = ((r_1 * (K - y(1)) / K) + betaP_S(y(3))) * y(2) - ((r_2 * (K - y(1)) / K) + r_3 * y(1) / K + psiP_R(y(4)) + gammaP_N(y(2))) * y(3); % Stressed population ODE

dydt(4) = ((r_2 * (K - y(1)) / K) + psiP_R(y(4))) * y(3) + deltaP_S(y(3)) * y(2);  % Recovered population ODE

This system captures the interactions between fish and human populations, fishing effort, and various factors affecting the dynamics of the system.

# Analysis
The analysis section includes parameters and calculations related to stress, recovery, and population dynamics. Key variables include growth rates (r_1, r_2, r_3), carrying capacity (K), and various functions (inv_stress_people_dec, people_never_stressed, etc.) used to analyze stress and recovery over time. Additionally, the function Analysis_System.m file is used. It works similarly to the ode_system2_2.m file execept the non-stressed class is broken into two classes. The ODE system is defined with five equations representing the fish population and different human populations (non-stressed never stressed, non-stressed but stressed before, stressed, and recovered).

dydt(1) = dxdt(y(1), E(y(2), y(3), y(1))); % Fish population ODE

dydt(2) = -((r_1 * (K - y(1)) / K) + betaP_S(y(4)) + deltaP_S(y(4))) * y(2); % Non-stressed never stressed population ODE

dydt(3) = ((r_3 * y(1) / K) + gammaP_N(y(2) + y(3))) * y(4) - ((r_1 * (K - y(1)) / K) + betaP_S(y(4)) + deltaP_S(y(4))) * y(3); % Non-stressed but stressed before population ODE

dydt(4) = ((r_1 * (K - y(1)) / K) + betaP_S(y(4))) * (y(2) + y(3)) - ((r_2 * (K - y(1)) / K) + r_3 * y(1) / K + psiP_R(y(5)) + gammaP_N(y(2) + y(3))) * y(4); % Stressed population ODE

dydt(5) = ((r_2 * (K - y(1)) / K) + psiP_R(y(5))) * y(4) + deltaP_S(y(4)) * (y(2) + y(3));  % Recovered population ODE 

One for members who have never been stressed and one for members that have been stressed before. Make sure the selections made in ode_system2_2.m matches the selections chosen in Analysis_System.m

# Plots
Several plots are generated to visualize the simulation results, including human and fish populations over time. The figures provide insights into the dynamics of non-stressed, stressed, and recovered populations.

# Additional Note
Note that across files, alpha, phi, c, and some others are defined seperately in each file. They must match across files to get outputs that correspond. Be on the lookout for this. 

# Usage
To run the simulation and analyze the results:

Ensure MATLAB is installed on your system.
Copy the provided code into a MATLAB script or live script.
Run the script in MATLAB.
Adjust parameters as needed for specific scenarios or experiments.

# Contributors
Author: Maggie Sullens 

Thanks to Dr. Justin Wright for help with complex contagion aspect of the code, Dr. David Finnoff and Katie Barkley for analysis contributions, Dr. Nina Fefferman for advising.

# License
This project is licensed under the MIT License.
