/* Defining Categorical Variables */ 
%let categorical=House_Style2 Overall_Qual2 Overall_Cond2 Fireplaces  
         Season_Sold Garage_Type_2 Foundation_2 Heating_QC  
         Masonry_Veneer Lot_Shape_2 Central_Air; 
 
/* Defining Interval Variables */ 
%let interval=Gr_Liv_Area Basement_Area Garage_Area Deck_Porch_Area  
         Lot_Area Age_Sold Bedroom_AbvGr Total_Bathroom; 

/* post hoc pairwise comparisons */
/* which groups are different from each other? */
proc glm data=stat.ameshousing3 plots(only)=(diffplot(center) controlplot);
	class heating_qc;
	model saleprice=heating_qc;
	lsmeans heating_qc/pdiff=all adjust=tukey;
	lsmeans heating_qc / pdiff=control("Average/Typical") adjust=dunnett;
	format heating_qc $Heating_QC.;
	title "post-hoc analysis of ANOVA - Heating quality as predictor";
run;