proc freq data=bootcamp.ameshousing3;
tables bonus fireplaces lot_shape_2 fireplaces*bonus lot_shape_2*bonus/ plots(only)=freqplot(scale=percent);
format bonus bonusfmt.;
run;

proc univariate data=bootcamp.ameshousing3 noprint;
class bonus;
var basement_area;
histogram basement_area;
inset mean std median min max / format=5.2 position=nw;
format bonus bonusfmt;
run;