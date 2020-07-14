/* Observations can be outliers, influential, both, or neither */
/* can use studentized residuals and rstudent residuals to detect outliers
   cook's d, dffits, or dfbetas to detect influential observations */

/* studentized residual value of 2 for small datasets and 3 for large datasets are the cutoffs for outliers
   indicates the number of standard deviations away from the mean of the residuals */

/* Proc reg produces MANY plots to visualize if there are outliers or influential points.
   You can also output studentized residuals (student), Rstudent residuals (Rstudent), dffits (dffits),
   Cook's D (cookd) and the hat matrix value (h).  By outputing this to a data set, you can easily subset to find suspect observations */ 


proc reg data=stats.ameshousing3_train plots(unpack) = all;
  model SalePrice=&interval/influence spec partial;
  output out=check r=residual p=pred rstudent=rstudent h=leverage cookd=cookd;
run;
quit;

