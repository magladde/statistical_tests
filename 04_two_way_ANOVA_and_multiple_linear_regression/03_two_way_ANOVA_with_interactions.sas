/* sliced ANOVA results (sliced refers to in variable comparisons ie does price change from season to season within excellent heating quality homes?)*/
proc glm data=stat.ameshousing3 order=internal plots(only)=intplot;
class season_sold heating_qc;
model saleprice = heating_qc|season_sold;
lsmeans heating_qc*season_sold / diff slice=heating_QC;
store out = interact;
title "Analyze the effects of season";
title2 "at each level of heating quality";
run;

/* Further slicing results */
proc plm restore=interact plots=all;
slice heating_qc*season_sold / sliceby=heating_qc adjust=tukey;
effectplot interaction(sliceby=heating_qc) / clm;
run;