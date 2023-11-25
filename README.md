# Doomed_Harvest

## How an Industry Collapse Affects Community Mental Health: a Complex Contagion Model
The goal of this code is to simulate the collapse of a fish population and how fishermen transition through different stress classes through simple and complex contagion processes. Figures are created to show the transitions through time.

## Code Description
The code is written in matlab. The ode_code.m is where intial population sizes are set before solve the ode system which is done by calling the ode_system2_2.m file. Within this file, the fishing effort function can be chosen by commenting out the undesired one. Parameters of the function can also be set to desired values. Make sure the correct number of inputs matches in the E() input of dxdt(1) in line 102. Set the catchability to the desired value (must be between 0 and 1). Select the desired fish population decline function in a similar way as the fishing effort function and change parameters to desired values. After setting the parameters for community connectedness, the following matlab functions are the complex contagion components of model. The expectation of changing states is calculated by summing over the probability of coming into contact with that specific number of people in a class multiplied by the inflence that number of people have on an individual, starting at 1 and ending with every member of that class. Then the transition parameters are set and the ode system follows.

The analysis of the system is used with the Analysis_System.m file. It works similarly to the ode_system2_2.m file execept the non-stressed class is broken into two classes. One for members who have never been stressed and one for members that have been stressed before. Make sure the selections made in ode_system2_2.m matches the selections chosen in Analysis_System.m

Within ode_code.m, the average time a person is stressed (avg_time_stressed), amount of people who skipped the stressed state (total_people_never_stressed), the total people that experienced stressed (total_people_that_were_stressed), the max number of people stressed at one time (max_stressed), and the event duration (time_of_stress) are calculated. A series of plots are made. The first is the population of each class over time. The second plot, is the fish population along with the population of each class, but breaks the non-stressed class into the two categories. Next there are figures for the growth and effort versus time and fish population


Note that across files, alpha, phi, c, and some others are defined seperately in each file. They must match across files to get outputs that correspond. Be on the lookout for this. 

## How to Run the Code
Download and ensure all files are in the same folder. Run in Matlab

## Credits
Thanks to Dr. Justin Wright for help with complex contagion aspect of the code, Dr. David Finnoff and Katie Barkley for analysis contributions, Dr. Nina Fefferman for advising.
