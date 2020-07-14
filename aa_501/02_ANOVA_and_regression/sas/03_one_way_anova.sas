/* Defining Categorical Variables */ 
%let categorical=House_Style2 Overall_Qual2 Overall_Cond2 Fireplaces  
         Season_Sold Garage_Type_2 Foundation_2 Heating_QC  
         Masonry_Veneer Lot_Shape_2 Central_Air; 
 
/* Defining Interval Variables */ 
%let interval=Gr_Liv_Area Basement_Area Garage_Area Deck_Porch_Area  
         Lot_Area Age_Sold Bedroom_AbvGr Total_Bathroom; 

/* Descriptive Statistics across groups */
proc means data=bootcamp.ameshousing3 printalltypes maxdec=3;
var saleprice;
class heating_qc;
title "Descriptive Statistics of Sales Price";
run;

proc sgplot data=bootcamp.ameshousing3;
vbox saleprice / category=heating_qc connect=mean;
title "Sale price differences across heating quality";
run;

/* We see differences across heating_qc, but are these differences statistically significant? need to use a statistical test to determine
since we have more than two groups we cannot use a t-test we use anova to test more than 2 groups */

/* One-way ANOVA */
proc glm data=bootcamp.ameshousing3;
class heating_qc;
model saleprice=heating_qc;
format heating_qc $Heating_QC.;
title "One way anova with heating quality as predictor";
run;

/* for ANOVA tests to hold we need to verify the assumptions of ANOVA
1. Independence - no test, you need to think about the data to verify this
2. Data comes from normally distributed samples - we will eye ball normality for now, tests will come later
3. Groups have equal variances - HOVTEST option in the means statment, H0 for this test is that variances are equal for all populations */
/* run proc univariate to get qq plot to check for normality of groups */

/* all qqplots are essentially straight lines, good enough for now! normality is confirmed */
proc univariate data=stat.ameshousing3;
	class heating_qc;
	var saleprice;
	hist saleprice;
	probplot saleprice/normal;
run;

/* levenes test for homogenaity fails to reject the null hypothesis, variance is equal in our groups */ 
proc glm data=stat.ameshousing3 plots=all;
	class heating_qc;
	model saleprice=heating_qc;
	means heating_qc/hovtest=levene;
	format heating_qc $Heating_QC.;
	title "One-Way ANOVA equal variance test";
run;