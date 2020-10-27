# KCL_UK: Renervate
Open-source software created by Renervate, KCL iGEM 2020. Here you can find our scaffold degradation simulation program, and our Grasshopper algorithm 'The Porosifier' - of which adds pores to an arbitrary shape


# Project Abstract
Annually, between 250,000 and 500,000 individuals worldwide suffer from a spinal cord injury (SCI). SCI is characterised by damage to the spinal cord followed by a complex pathophysiological response and loss of neuronal function below the site of injury. The limited regenerative abilities of the CNS combined with the inhibitory environment created by the glial scar at the affected area pose numerous challenges to restoring function. Working towards a therapy for SCI, we have designed and modelled a biodegradable scaffold composed of polycaprolactone, that incorporates a synthetic mussel-foot protein based bioadhesive coating, to encourage axonal attachment, and can be produced using 3D-bioprinting methods. Our scaffold is customisable and contains the necessary micro- and macro-architectures predicted to topographically encourage axonal regrowth and withstand the mechanical forces in the spine. We have further investigated in silico the physicochemical properties of our chosen protein Pvfp-5β to better understand its biotherapeutic use.

# Scaffold Degradation Simulator
This MATLAB program can be utilised to simulate the degradation of a polymer scaffold over a specified time period, based on a given degradation rate (of any polymer that undergoes bulk erosion) or known porosity (the latter relationship between porosity and degradation has been coded specifically for our material, polycaprolactone, but may be edited with ease). We wrote this program, due to lack of similar software, and it is especially useful for deciding scaffold parameters if lab access isn't possible or for any preliminary scaffold parameter decisions.

There are a number of options for running the program:
* The prediction of degradation based on a known degradation rate and initial molecular weight
* The prediction of degradation based on a known porosity (note: this is hardcoded for PCL) and initial molecular weight
* The option to input a critical molecular weight so that a warning dialogue will be shown if the scaffold will degrade beyond this in a set time frame
* The calculation of a mimimum required initial molecular weight, given a critical molecular weight value (i.e. the limit of molecular weight such that the scaffold is useful), the amount of time the scaffold should last, and a known degradation rate or porosity. This is followed by a prediction of the degradation in a specified time frame.

Furthermore, there are customisation options - the units used throughout the program may be adjusted.

More information, and examples of how we used this software to aid our project can be found on our wiki Degradation Modelling page ([here](https://2020.igem.org/Team:KCL_UK/Degradation_Model)), as well as on our Contribution page ([here](https://2020.igem.org/Team:KCL_UK/Contribution)).

![Pore Image](https://2020.igem.org/wiki/images/4/4e/T--KCL_UK--DegradationRateGraph.png)

<i>Fig. 1: Example scaffold degradation prediction for a PCL scaffold of 58% porosity</i>

# The Porosifier
This is a Grasshopper script file that may be opened within Rhinoceros. When designing our scaffold, we found there to be a lack of easily accessible software to create a porous surface structure on a given CAD file. Grasshopper 3D allows for the visual coding of algorithms that govern the design of an object in the Rhino environment. We used this to create <b>The Porosifier</b>. This .gh file may be applied to any arbitrary shape, and has the customisation options for the adjustment of pore size and porosity of the object. This is not only useful for our specific applciation (creating a spinal cord scaffold), but for wider applications where a porous media is required. It is relatively simple to use; the sliders may be adjusted for cell size and thickness, and the algorthim will generate a new porous design. 

Our specific usage, as well as the background behind this, may be found on our Scaffold Design wiki page, ([here](https://2020.igem.org/Team:KCL_UK/Scaffold_Design)).

![Pore Image](https://2020.igem.org/wiki/images/1/13/T--KCL_UK--porething.png)

<i>Fig. 2: Here you can see the algorithm applied to an arbitrary sphere alongside our final scaffold design</i>

# iGAM Software 
Through our collaboration with The University of Calgary 2020 iGEM Team, we have developed the MFP iGAM script to predict genetic algorithms for our particular mussel foot protein, Pvfp-5β. More information regarding iGAM can be found ([here]((https://2020.igem.org/Team:Calgary/iGAM)).
