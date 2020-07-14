
/********************************************************************/
/************************************Not Constant Variance ****************/

data trans;
input obs x y;
datalines;
1 1 21.191 
2 2 24.673 
3 3 32.988 
4 4 33.131 
5 5 33.743 
6 6 51.034 
7 7 31.468 
8 8 66.324 
9 9 55.731 
10 10 43.445 
11 11 36.197 
12 12 30.410 
13 13 69.602 
14 14 56.504 
15 15 85.681 
16 16 61.759 
17 17 41.196 
18 18 83.019 
19 19 160.206 
20 20 115.455 
21 21 27.436 
22 22 79.797 
23 23 108.870 
24 24 62.933 
25 25 113.648 
26 26 81.484 
27 27 108.889 
28 28 165.372 
29 29 134.783 
30 30 111.471 
;

proc reg data=trans;
  model y=x;
  output out=check r=residual p=pred;
run;
quit;
/* Need to create absolute values of residuals before calculating 
   Spearman correlation  */
data check;
  set check;
  abserror=abs(residual);
run;

/* Calculate spearman correlation between abs(residuals) and predicted values  */
proc corr data=check spearman nosimple;
  var abserror pred;
run;

/* Perform test of normality of residuals  */
proc univariate data=check normal plots;
 var residual;
 probplot;
run;


/* Run the regression model to see that the variance is not constant  */
proc reg data=trans;
  model y=x;
run;
quit;

/* Can use the variance-stabilizing log transformation to transform the variance */
data trans2;
 set trans;
 logy=log(y);
 run;

/* Run the regression model with the log transformed y to see that variance is now constant */
 proc reg data=trans2;
   model logy=x;
   run;
   quit;