/* Defining Categorical Variables */
%let categorical=House_Style Overall_Qual Overall_Cond Year_Built 
         Fireplaces Mo_Sold Yr_Sold Garage_Type_2 Foundation_2 
         Heating_QC Masonry_Veneer Lot_Shape_2 Central_Air;

/* Defining Interval Variables */
%let interval=SalePrice Log_Price Gr_Liv_Area Basement_Area 
         Garage_Area Deck_Porch_Area Lot_Area Age_Sold Bedroom_AbvGr 
         Full_Bathroom Half_Bathroom Total_Bathroom ;

/* Scatter plot of a single variable against target */
proc sgscatter data=stat.ameshousing3;
	plot saleprice*gr_liv_area / reg; * reg plots the regression;
	title "Associations of Above Grade Living Area with Sale Price";
	*label gr_liv_area="Greater Living Area"; *changes x axis label;
run;

/* Scatter plot of two continuous variables with targetr */
proc sgscatter data=stat.ameshousing3;
plot saleprice*(gr_liv_area yr_sold);
title "Associations of two variables with sale price";
run;

/* Scatter plots of ALL/multiple continuous varaibles with target */
proc sgscatter data=stat.ameshousing3;
	plot saleprice*(&interval) / reg;
	title "Associations of Interval Variables with Sale Price";
run;