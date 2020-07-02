/* Defining Categorical Variables */
%let categorical=House_Style Overall_Qual Overall_Cond Year_Built 
         Fireplaces Mo_Sold Yr_Sold Garage_Type_2 Foundation_2 
         Heating_QC Masonry_Veneer Lot_Shape_2 Central_Air;

/* Defining Interval Variables */
%let interval=SalePrice Log_Price Gr_Liv_Area Basement_Area 
         Garage_Area Deck_Porch_Area Lot_Area Age_Sold Bedroom_AbvGr 
         Full_Bathroom Half_Bathroom Total_Bathroom ;

/* Descriptive statistics across groups step 1 exploratory analysis */
proc means data=stat.ameshousing3 printalltypes maxdec=3;
	var saleprice;
	class heating_qc;
	title "descriptive statistics of sales price";
run;

/* Box plots if numbers look like there might be a difference step 2 exploratory analysis */
proc sgplot data=stat.ameshousing3;
	vbox saleprice / category=heating_qc connect=mean;
	title "sale price differences across heating quality";
run;

/* at this point no statistical test has been performed, how to we test what we see in the above graphics? */
proc glm data=stat.ameshousing3;
	class heating_qc;
	model saleprice=heating_qc;
	format heating_qc $Heating_QC.;
	title "One-Way ANOVA with heating quality as predictor";
	run;

/* for ANOVA tests to hold we need to verify the assumptions of ANOVA
1. Independence - no test, you need to think about the data to verify this
2. Data comes from normally distributed samples - we will eye ball normality for now, tests will come later
3. Groups have equal variances - HOVTEST option in the means statment, H0 for this test is that variances are equal for all populations */
/* run proc univariate to get qq plot to check for normality of groups */

/* all qqplots are essentially straight lines, good enough for now! */
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