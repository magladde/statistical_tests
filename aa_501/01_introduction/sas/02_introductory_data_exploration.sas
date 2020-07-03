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

/* Exploring data */
/* Listing out observations in dataset */
proc print data=bootcamp.ameshousing3(obs=10);
title "Listing of the Ames Housing Data Set";
run;

/* Frequencies of Categorical Variables */
proc freq data=bootcamp.ameshousing3;
tables &categorical / plots=freqplot;
format house_style $house_style.
overall_qual Overall.
overall_cond overall.
heating_qc $heating_qc.
central_air $noyes.
masonry_veneer $noyes. ;
title "Categorical Variable Frequency Analysis";
run;

/* Basic Summary Statistics */
proc means data=bootcamp.ameshousing3;
var &interval;
title "Descriptive Statistics of ameshousing3 Data";
run;

/* Splitting the Summary Statistics by House Style */
proc means data=bootcamp.ameshousing3;
class house_style;
var saleprice;
title "Descriptive Statistics of ameshousing3 Data";
run;

/* Calculating other summary statistics */
proc means data=bootcamp.ameshousing3 maxdec=2 n mean median std q1 q3 range missing nmiss;
var saleprice;
title "Selected Descriptive Statistics";
run;

/* Distribution Exploration of Interval Variables */
ods select histogram;
proc univariate data=bootcamp.ameshousing3 noprint;
var &interval;
histogram &interval / normal kernel;
inset n mean std /position=ne;
title "Interval Variable Distribution Analysis";
run;

/* Summary Statistics, Histograms, & QQ-Plots */
proc univariate data=bootcamp.ameshousing3;
var saleprice;
histogram saleprice / normal(mu=est sigma=est) kernel;
inset skewness kurtosis / position=ne;
probplot saleprice / normal(mu=est sigma=est);
inset skewness kurtosis;
title "Descriptive Statistics of Sales Price";
run;

/* Vertical Box-plot with SGPLOT */
proc sgplot data=bootcamp.ameshousing3;
vbox saleprice/ datalabel=Overall_qual;
refline 135000/ axis=y label;
title "Box plots of sales prices";
run;
























