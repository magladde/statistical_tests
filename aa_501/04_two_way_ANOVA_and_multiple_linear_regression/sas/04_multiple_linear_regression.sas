/* Defining Categorical Variables */
%let categorical=House_Style2 Overall_Qual2 Overall_Cond2 Fireplaces 
         Season_Sold Garage_Type_2 Foundation_2 Heating_QC 
         Masonry_Veneer Lot_Shape_2 Central_Air;

/* Defining Interval Variables */
%let interval=Gr_Liv_Area Basement_Area Garage_Area Deck_Porch_Area 
         Lot_Area Age_Sold Bedroom_AbvGr Total_Bathroom;

/* fitting a multiple linear regression model */
proc reg data=bootcamp.ameshousing3 plots(unpack);
model saleprice=basement_area lot_area;
title "Model with basement area and lot area";
run;

/* Using proc glm for regression */
proc glm data=bootcamp.ameshousing3;
model saleprice= basement_area lot_area / solution;
title "Model with basement area and lot area";
run;