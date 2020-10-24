# The Porosifier
The purpose of the Grasshopper script is to create pores on any given CAD file - adjusting the detailed parameters will allow for a change in pore size and density.

## Requirements
* Rhinoceros software (https://www.rhino3d.com/), which comes with the Grasshopper Extension pre-installed
### Grasshopper plug-ins 
* Crystallon (https://www.food4rhino.com/app/crystallon) This is the main add-on used within The Porosifier. We'd like to thank Aaron Porterfield, the creator of this add-on, for his guidance within creating this algorithm
* Weaverbird
<i>Note: any missing plug-ins should be flagged when opening the .gh file on Rhino6 or later.</i>

## Instructions
1. Open CAD file within Rhino, if not already designing it within the software, alongside this .gh file
2. Ensure that the object is centred on (0,0,0) - the origin - so that the algorithm will run as intended, and right click on the first brep box to select the object of interest within Rhinoceros
3. Adjust the voxel size using the slider - note that a smaller voxel size will result in a longer run time
4. Select the type of unit cell - we have used Gyroid as a default (this is our recommendation). It should be of shell type.
5. Adjust the thickness (the appropriate slider may be found by left clicking on the thickness note and following the green line to the slider)
6. After updating the parameters in steps 3-5, the pore size, volumes and relative density should automatically update

## Side note
Dependent on the geometry complexity, and size of the voxels, the program may take a long time to run - or Rhino may even stop responding. If this is the case, allow time for the algorithm to run as it may be computationally expensive.
