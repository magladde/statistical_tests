proc freq data=bootcamp.ameshousing3;
tables (lot_shape_2 fireplaces)*bonus/chisq expected cellchi2 nocol nopercent relrisk;
format bonus bonusfmt.;
run;

proc freq data=bootcamp.ameshousing3;
tables fireplaces*bonus / chisq measures cl;
title "Ordinal Association between FIREPLACES and BONUS?";
run;