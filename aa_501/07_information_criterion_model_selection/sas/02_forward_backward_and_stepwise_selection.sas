/*  Using PROC GLMSELECT for forward, backward and stepwise selection  */

%let interval=Gr_Liv_Area Basement_Area Garage_Area Deck_Porch_Area Lot_Area Age_Sold Bedroom_AbvGr Total_Bathroom;
ods graphics on;
%let categorical=House_Style2 Overall_Qual2 Overall_Cond2 Fireplaces Season_Sold Foundation_2 Heating_QC Masonry_Veneer Lot_Shape_2 Central_Air;

proc glmselect data=stats.ameshousing3_train plots=all;
  FORWARD: model SalePrice=&interval/selection=forward details=steps select=SL slentry=0.05;
  title "Forward Model Selection for SalePrice-SL 0.05";
  store out=stats.glmameshousing3forward;
run;

proc glmselect data=stats.ameshousing3_train plots=all;
  BACKWARD: model SalePrice=&interval/selection=backward details=steps select=SL slstay=0.05;
  title "Backward Model Selection for SalePrice-SL 0.05";
  store out=stats.glmameshousing3back;
run;

proc glmselect data=stats.ameshousing3_train plots=all ;
  STEPWISE: model SalePrice=&interval/selection=stepwise details=steps select=SL slstay=0.05 slentry=0.05;
  title "Stepwise Model Selection for SalePrice-SL 0.05";
  store out=stats.glmameshousing3step;
run;

/* **************************************************************  */

/* Using PROC GLMSELECT with other selection criterion  */
proc glmselect data=stats.ameshousing3_train plots=all;
  STEPWISEAIC: model SalePrice=&interval/selection=stepwise details=steps select=AIC;
  title "Stepwise model for SalePrice - AIC";
  store out=stats.glmameshousing3AIC;
run;

proc glmselect data=stats.ameshousing3_train plots=all;
  STEPWISESBC: model SalePrice=&interval/selection=stepwise details=steps select=SBC;
  title "Stepwise model for SalePrice - SBC";
  store out=stats.glmameshousing3SBC;
run;

proc glmselect data=stats.ameshousing3_train plots=all;
  STEPWISEAIC: model SalePrice=&interval/selection=stepwise select=AIC stop=SBC;
  title "Stepwise model for SalePrice - AIC";
  store out=stats.glmameshousing3AIC;
run;