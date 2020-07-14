/* effects coding needs n-1 varaibles to describe n number of levels of a variable
   class      value    design variables
                          1      2
   fireplaces    0        -1     -1
                1         1      0
                2         0      1 
intercept becomes the average of all homes regardless of fireplace*/

/* reference coding

   class      value    design variables
                          1      2
   fireplaces    0         0      0
                1         1      0
                2         0      1 
intercept becomes the average value for 0 fireplaces*/

proc logistic data=bootcamp.ameshousing3 plots(only)=(effect oddsratio);
class Fireplaces(ref="0") lot_shape_2(ref="Regular") / param=reference;
model bonus(event="1") = basement_area fireplaces lot_shape_2 / clodds=pl;
units basement_area=100;
title "LOGISTIC MODEL (2): Bonus = basement_area fireplaces lot_shape_2";
run;
