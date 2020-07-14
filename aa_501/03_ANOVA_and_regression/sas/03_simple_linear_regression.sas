/* Defining Categorical Variables */ 
%let categorical=House_Style2 Overall_Qual2 Overall_Cond2 Fireplaces  
         Season_Sold Garage_Type_2 Foundation_2 Heating_QC  
         Masonry_Veneer Lot_Shape_2 Central_Air; 
 
/* Defining Interval Variables */ 
%let interval=Gr_Liv_Area Basement_Area Garage_Area Deck_Porch_Area  
         Lot_Area Age_Sold Bedroom_AbvGr Total_Bathroom; 

/* Simple linear regression */
proc reg data=bootcamp.ameshousing3;
model saleprice=lot_area;
title "Simple Linear Regression with lot area as predictor";
run;