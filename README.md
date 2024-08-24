# Borealis
## About This Project

This repository contains an alternative user interface for the HarpVis software, a powerful tool designed for the visualization, styling, and modification of meteorological data plots. This custom UI enhances user experience by providing a more intuitive and streamlined way to interact with HarpVis's rich feature set.
Key Features:

- Improved Usability: Simplified workflows and a more intuitive layout make it easier for users to navigate and utilize the full capabilities of HarpVis.
- Customizable Styling: Enhanced controls for styling plots, allowing users to fine-tune the appearance of their meteorological visualizations.
- Advanced Plot Modifications: Easily modify and manipulate plot data to suit specific analytical needs, with clear visual feedback and control options.

## Why This Project?

While HarpVis is an excellent tool for meteorologists and data analysts, this alternative UI addresses common user pain points by offering a more user-friendly interface, thus making the software more accessible to both beginners and advanced users.

## Getting Started

To get started with this alternative UI for HarpVis, check out the Installation and Usage sections. Contributions are welcome; see the Contributing guidelines for more information.

## Installation
This section will guide you through the initial process of installing Borealis to the right directory
1. **Selecting the right location**   
   Open a terminal and navigate to the harp folder.
   This is the folder that Borealis expects to be a sub folder off

2. **Clone the repository:**   
   Next clone the repository into the harp folder by using the following command
   ```bash
   git clone https://github.com/SverreFH/Borealis.git

And that is all for the installation procces. For further information on how to start the software see the Usage section.

## Usage   
### Starting Borealis   
This section will guide you through the proccess of starting the Borealis software.
1. **Navigating to the correct folder**   
   The first step in starting the software is to ensure that you have navigated to the harp folder in a terminal.
2. **Intializing R**   
   Next you need to make sure that you have initialized the R package using the following command:
   ```bash
   module load R
3. **starting R**   
   Next start R using the following command:
   ```bash
   R
4. **Running Boreais**   
   Next you will need to run Borealis with the following command:
   ```bash
   shiny::runApp("Borealis/main.R")
   ```   
   After running this command the terminal should print which port Borealis is transmitting from. Take note of this port. We will need this later.
5. **Establishing remote connection**
   For the final step we will establish a remote connection to the vm. From a terminal on the vm run the following command. Be sure to replace {port} with the port you got in the last step, and {EC} with your EC session.
   ```bash
   ssh -L {port}:localhost:{port} {EC}
   ```
   Now the remote connection should be established, and you can open Borealis in the webbrowser by entering the following: http://127.0.0.1:{port}/

### Using Borealis   
Now tha Borealis is upp and running we need to know how to use the software. This section will cover that, explaining differnt UI elements in their own sections.
### The Sidebar   
The sidebar section of the software is where the majority of functionality relatet to the creation of plots are located. The sidebar is splitt into three subsections indicated by the tabs at the tob of the sidebar. 
This section will therefore be splitt into three sub sections each covering one of the sidebar tabs.
#### The Selection Tab   
The selection tab is where you as the user can sellect what experiments, daterange and paramaters to plot for. First you will need to select a directory where the software can find the experiment files. When a directory has been selected
the experiment selection input should be enabled, now showing all possibe experiment to plot for given the experimentfiles the software found in the selected directory. Next the daterange selection field is enabled allowing the selection of dateranges that 
exist for the selected experiments in the selected directory. When a daterange is selected the software creates toggle buttons for each possible selectable paramater. You as the user can toggle a paramater on or of by pressing it. Additionally their is a selction field
allwouing you to select the score to plot. When something has been choosen in all the fields the plot button is enabled, and when pressed creates the a plot for each selected paramater. 
#### The styling Tab   
The styling tab allows you as the user to set both the color and nickname of each experiment that will be plotted for. Not that these must be set before pressing plot to be added to the plot. Each experiment has its own styling card where you can modify their apperance.
As this tab is reliant on a list of experiments, it is not populated before you have selected experiments in the selection tab. 
#### The Axis Tab   
The axis tab works much like the sytling tab. The axis tab creates a axis card for each selcted paramater. From these cards you can change the plot name, x-name, y-name, y-min and y-max for the given paramaters plot. Note that this section is empty untill you have selected 
at least one paramater.
### The viewport   
The viewport takes upp the center of the screen and is where your plots are displayed. Each one of your plots gets its own tab at the top of the viewport, where each tab is marked by what paramater it is a plot for. Note that if there are allready plots in the view port and you plot again
then the old plots will be replaced with the new ones. 
### The Interactive Area    
The interactive Area shows options for modifying your selected plot. The interactive options change based on the score and paramater of selected plot. Currently there is one interactive option for changing a plots level, and a option for highlighting members. In order to apply your changes press the 
apply button and wait for you changes to apear. In addition too options that are spesific for score and paramater ther is a save button. Pressing the save button opens a menu where you can save your selected plot. By default the saved plots end up in the plots subfolder of Borealis. 

## Contributing Guidelines   
You are welcome to make contributions to Borealis but we ask that you keep in mind a few guidelines. When contributiong never push your changes directly to the main branch, instead create a branch for the work you need to do and push to that branch. When you are done implementing the changes to your branch
create a pull request and wait for the request to be reviewd. If your changes pass review you are welcome to execute the pull request. Further when working on your branch ensure that you create descriptive commit messages, so that it is easier to se what changes have been made. Additionally commit small and often.
Lastly attempt to follow the already existing folder strucutre, and ensure that you never create more than one observer for an event. 
