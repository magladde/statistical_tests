/* code to detect autocorrelation (correlation across time with each other) */
/* null hypothesis is that there is not correlation */
/* durbin watson score of 2 is a good clear value (no correlation) */
proc reg data=bootcamp.minntemp;
model temp=time timesq/dwprob;
run;