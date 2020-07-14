/* Defining Categorical Variables */
%let categorical=House_Style2 Overall_Qual2 Overall_Cond2 Fireplaces 
         Season_Sold Garage_Type_2 Foundation_2 Heating_QC 
         Masonry_Veneer Lot_Shape_2 Central_Air;

/* Defining Interval Variables */
%let interval=Gr_Liv_Area Basement_Area Garage_Area Deck_Porch_Area 
         Lot_Area Age_Sold Bedroom_AbvGr Total_Bathroom;

/* two-way ANOVA */
proc glm data=bootcamp.ameshousing3 order=internal;
class season_sold heating_qc;
model saleprice=heating_qc season_sold;
lsmeans season_sold / diff adjust=tukey;
format season_sold Season.;
title "Model with heating quality and season as predictors";
run;

/* two-way ANOVA with interactions */
proc glm data=bootcamp.ameshousing3 order=internal plots(only)=intplot;
class season_sold heating_qc;
model saleprice=heating_qc season_sold heating_qc*season_sold/ss1 ss3;
format season_sold Season.;
title "model with heating quality and season as interacting predictors";
run;

/* sliced ANOVA results */
proc glm data=bootcamp.ameshousing3 order=internal plots(only)=intplot;
class season_sold heating_qc;
model saleprice=heating_qc|season_sold;
lsmeans heating_qc*season_sold / diff slice=season_sold;
store out=interact;
title "Analyze the effects of seaons at each level of heating quality";
format season_sold Season.;
run;

proc plm restore=interact plots=all;
slice heating_qc*season_sold / sliceby=season_sold adjust=tukey;
effectplot interaction(sliceby=season_sold) / clm;
run;