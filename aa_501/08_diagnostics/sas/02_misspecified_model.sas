cas;
caslib _all_ assign;
libname stats '/opt/sas/home/sjsimmo2/sasuser.viya/stats';
proc datasets library=public;
copy out=stats in=public;
run;
quit;


%let interval=Gr_Liv_Area Basement_Area Garage_Area Deck_Porch_Area Lot_Area Age_Sold Bedroom_AbvGr Total_Bathroom;
ods graphics on;
%let categorical=House_Style2 Overall_Qual2 Overall_Cond2 Fireplaces Season_Sold  Foundation_2 Heating_QC Masonry_Veneer Lot_Shape_2 Central_Air;

/* Create data sets using the data step  */
/* This is the one we will be using moving forward */
data stats.ameshousing3_train stats.ameshousing3_valid;
  set stats.ameshousing3;
  call streaminit(12345);
  random = RAND("Uniform");
  if random <= 0.2 then output stats.ameshousing3_valid;
  else output stats.ameshousing3_train;
run;


Chapter 5
/***********************************************************************/
/*********************************Misspecified Model ********************/

/*  Data set to illustrate polynomial regression */
data paper;
input obs amount strength;
datalines;
1 1 2.4
2 1 2.6
3 1 2.7
4 2 2.5
5 2 2.6
6 2 2.6
7 2 2.7
8 2 2.8
9 3 2.8
10 3 2.8
11 3 3.0
12 3 3.0
13 4 3.0
14 4 2.9
15 4 2.9
16 4 3.0
17 4 3.1
18 5 2.9
19 5 2.9
20 5 3.0
21 5 2.9
22 5 2.8
;
run;
/* Plot to view data */
proc sgplot data=paper;
  scatter x=amount y=strength;
  title "Paper data";
run;

/* Use sgplot to view data with a regression line through it */
proc sgplot data=paper;
  reg x=amount y=strength/lineatrs=(color=blue pattern=solid);
  title �Paper data-Linear �;
run;

/* Run a simple linear regression. Will see the residual plot has a curvature to it */
proc reg data=paper;
  model strength=amount;
run;
quit;


/* Can use glmselect to select how high of power to use */
/* Should use hierarchy = single to ensure no aliasing occurs */
proc glmselect data=paper outdesign=paper2;
  effect p_effect=polynomial (amount/degree=4);
  model strength=p_effect/selection=backward select=SL slstay=0.05
    hierarchy=single showpvalues;
  title �Paper data: backward selection�;
run;
quit;

/* The data created in paper2 (in outdesign) can be used in proc reg 
    to determine the appropriateness of the model. ALL of the variables
    in the final model (including any interaction and higher order terms
    will be saved in &_GLSMOD.  */

proc reg data=paper2 plots=all;
  model strength=&_GLSMOD/lackfit;
run;
quit;


/* An illustration with a fairly complex model...interactions and higher order terms  */
proc glmselect data=ameshousing3_train outdesign=ames3;
  effect p_effect=polynomial (age_sold/degree=4); 
  model saleprice=Gr_Liv_Area|Basement_Area|Garage_Area|Deck_Porch_Area|Lot_Area|Bedroom_AbvGr|Total_Bathroom|p_effect @2/selection=backward select=SL slstay=0.05
    hierarchy=single showpvalues;
run;
quit;

/* Now send it to proc reg to investigate whether or not the model is appropriate 
  use output to output residuals and predicted values to a different data set  */
proc reg data=ames3;
  model SalePrice=&_GLSMOD;
  output out=check r=residual p=pred;
run;
quit;