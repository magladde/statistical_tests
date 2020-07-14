/* backward selection using proc logistic */
proc logistic data=bootcamp.ameshousing3 plots(only)=(effect oddsratio);
class fireplaces(ref="0") lot_shape_2(ref="Regular") / param=ref;
model bonus(event="1") = basement_area|fireplaces|lot_shape_2 @2 / selection=backward clodds=pl slstay=0.1;
units basement_area=100;
title "LOGISTIC MODEL(3): Backward Elimination Bonus=Basement_area|fireplaces|lot_shape_2";
run;

data newhouses;
length lot_shape_2 $9;
input fireplaces lot_shape_2 $ basement_area;
datalines;
0 Regular 1060
2 Regular 775
2 Irregular 1100
1 Irregular 975
1 Regular 800
;
run;

/* can we predict with proc logistic? yes it has a built in score statement */
proc logistic data=bootcamp.ameshousing3;
class fireplaces(ref="0") lot_shape_2(ref="Regular") / param=ref;
model Bonus(event="1") = basement_area|lot_shape_2 fireplaces;
units Basement_area=100;
score data=newhouses out=scored_new;
run;

proc print data=scored_new;
run;