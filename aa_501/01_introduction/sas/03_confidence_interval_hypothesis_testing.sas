caslib _all_ assign; 

/******************************/
/* Introduction to Statistics */
/******************************/

/*******************/
/* Variable MACROS */
/*******************/

/* Defining Categorical Variables */
%let categorical=House_Style Overall_Qual Overall_Cond Year_Built 
         Fireplaces Mo_Sold Yr_Sold Garage_Type_2 Foundation_2 
         Heating_QC Masonry_Veneer Lot_Shape_2 Central_Air;

/* Defining Interval Variables */
%let interval=SalePrice Log_Price Gr_Liv_Area Basement_Area 
         Garage_Area Deck_Porch_Area Lot_Area Age_Sold Bedroom_AbvGr 
         Full_Bathroom Half_Bathroom Total_Bathroom ;

/* Confidence Intervals for the Mean*/
proc means data=bootcamp.ameshousing3 maxdec=2 n mean std stderr clm;
var saleprice;
title "95% Confidence Interval for Sales Price";
run;

/* Hypothesis Test */
ods graphics off;
ods select testsforlocation;
proc univariate data=bootcamp.ameshousing3 mu0=135000;
var saleprice;
title "Testing Whether the Mean of Sales Price = $135K";
run;
ods graphics on;

/* Hypothesis Test (another way) */
proc ttest data=bootcamp.ameshousing3 plots(showh0)=interval h0=135000;
var saleprice;
title "One-sample t-Test testing mean SalePrice=$135K";
run;

/* Two-sample t-Test */
proc ttest data=bootcamp.ameshousing3 plots(showh0)=interval;
class masonry_veneer;
var saleprice;
format Masonry_Veneer $NoYes.;
title "Two-sample t-test comparing Masonry Veneer, No vs. Yes";
run;