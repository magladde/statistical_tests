/* Exploring data for two-way ANOVA */
proc means data=stat.ameshousing3 mean var std nway;
class season_sold heating_qc;
var saleprice;
format Season_sold Season.;
title "Selected Descriptive Statistics";
run;

proc sgplot data=stat.ameshousing3;
vline season_sold / group=heating_qc stat=mean response=saleprice markers;
format season_sold Season.;
run;

/* it looks like both season and heating quality have an effect on the price of homes in ames iowa, lets thet this with a two-way anova! */
