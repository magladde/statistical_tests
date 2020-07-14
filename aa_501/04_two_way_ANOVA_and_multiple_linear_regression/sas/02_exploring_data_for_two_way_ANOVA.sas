/* Defining Categorical Variables */
%let categorical=House_Style2 Overall_Qual2 Overall_Cond2 Fireplaces 
         Season_Sold Garage_Type_2 Foundation_2 Heating_QC 
         Masonry_Veneer Lot_Shape_2 Central_Air;

/* Defining Interval Variables */
%let interval=Gr_Liv_Area Basement_Area Garage_Area Deck_Porch_Area 
         Lot_Area Age_Sold Bedroom_AbvGr Total_Bathroom;

/* exploring data for two-way anova */
proc means data=bootcamp.ameshousing3 mean var std nway;
class season_sold heating_qc;
var saleprice;
format season_sold Season.;
title "Selected Descriptive Statistics";
run;

proc sgplot data=bootcamp.ameshousing3;
vline season_sold / group=heating_qc stat=mean response=saleprice markers;
format season_sold Season.;
run;