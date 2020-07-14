proc logistic data=bootcamp.ameshousing3 alpha=0.05 plots(only)=(effect oddsratio);
model Bonus(event="1")=basement_area/clodds=pl;
title "LOGISTIC MODEL (1):Bonus=basement_area";
run;
/* you always have to make sure that model convergence status is satiffied or you cannot trustresults */
