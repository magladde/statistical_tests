/* Defining Categorical Variables */ 
%let categorical=House_Style2 Overall_Qual2 Overall_Cond2 Fireplaces  
         Season_Sold Garage_Type_2 Foundation_2 Heating_QC  
         Masonry_Veneer Lot_Shape_2 Central_Air; 
 
/* Defining Interval Variables */ 
%let interval=Gr_Liv_Area Basement_Area Garage_Area Deck_Porch_Area  
         Lot_Area Age_Sold Bedroom_AbvGr Total_Bathroom; 

/* Descriptive Statistics across groups */
ods graphics / reset=all imagemap;
proc corr data=bootcamp.ameshousing3 rank plots(only)=scatter(nvar=all ellipse=none);
var &interval;
with saleprice;
id PID;
title "Correlation and Scatter Plots with Sale Price";
run;

/* Correlation Matrix */
proc corr data=bootcamp.ameshousing3 nosimple plots=matrix(nvar=all histogram);
var saleprice &interval;
title "Correlations and Scatter Plot matrix of Predictors";
run;

proc corr data=bootcamp.ameshousing3 nosimple plots=matrix(nvar=all histogram);
var saleprice gr_liv_area basement_area;
title "Scatter Plot Matrix of Predictors";
run;
