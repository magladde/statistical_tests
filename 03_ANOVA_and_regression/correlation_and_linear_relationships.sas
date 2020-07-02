/* Defining Categorical Variables */
%let categorical=House_Style Overall_Qual Overall_Cond Year_Built 
         Fireplaces Mo_Sold Yr_Sold Garage_Type_2 Foundation_2 
         Heating_QC Masonry_Veneer Lot_Shape_2 Central_Air;

/* Defining Interval Variables */
%let interval=SalePrice Log_Price Gr_Liv_Area Basement_Area 
         Garage_Area Deck_Porch_Area Lot_Area Age_Sold Bedroom_AbvGr 
         Full_Bathroom Half_Bathroom Total_Bathroom ;

/* descriptive statistics across groups */
proc corr data=stat.ameshousing3 rank plots(only)=scatter(nvar=all 
		ellipse=none);
	var &interval;
	with saleprice;
	title "Correlations and Scatter Plots with SalePrice";
run;

/* correlation matrix */
proc corr data=stat.ameshousing3 nosimple plots=matrix(nvar=all histogram);
var saleprice gr_liv_area basement_area;
title "Scatter Plot Matrix of Predictors";
run;