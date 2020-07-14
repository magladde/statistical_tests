/* Creating a data set with Basement Area squared and Basement Area cubed */
data ames;
set stats.ameshousing3_train;
BA2=Basement_Area**2;
BA3=Basement_Area**3;
run;

/* Use vif, collin, and collinoint to explore if collinearity is an issue */
proc reg data=ames;
  model SalePrice=Basement_Area BA2 BA3/vif collin collinoint;
run;
quit;

/* Can center variables by using proc stdize (with method=mean) */
proc stdize data=stats.ameshousing3_train method=mean 
	out=ameshousing3_center (rename=(Basement_Area= Center_BA));
   	var Basement_Area;
run;

/* Now recreate higher order terms (or can just use proc glmselect to do this as well */
data ameshousing3_center;
  	set ameshousing3_center;
 	center_BA2=Center_BA**2;
	center_BA3=Center_BA**3;
run;

/*Now rerun regression....multicollinearity is not an issue now */
proc reg data=ameshousing3_center;
  model SalePrice = center_BA center_BA2 Center_BA3/vif collin collinoint;
run;
quit;