/* Defining Categorical Variables */
%let interval=Gr_Liv_Area Basement_Area Garage_Area Deck_Porch_Area Lot_Area Age_Sold Bedroom_AbvGr Total_Bathroom;
ods graphics on;
%let categorical=House_Style2 Overall_Qual2 Overall_Cond2 Fireplaces Season_Sold Foundation_2 Heating_QC Masonry_Veneer Lot_Shape_2 Central_Air;


/* Create data sets using the data step */
data ames_training ames_validation;
set bootcamp.ameshousing3;
call streaminit(12345);
random=RAND("Uniform");
if random <= 0.2 then output ames_validation;
else output ames_training;
run;

proc glmselect data=ames_training plots=all;
model saleprice=&interval/selection=forward details=steps select=SL slentry=0.05;
title "Forward Model Selection for SalePrice-SL 0.05";
store out=glmameshousing3forward;
run;

proc glmselect data=ames_training plots=all;
model saleprice=&interval/selection=backward select=SL slstay=0.05;
title "Backward Model Selection for SalePrice-SL 0.05";
store out=glmameshousing3forward;
run;

proc glmselect data=ames_training plots=all;
model saleprice=&interval/selection=stepwise details=steps select=SL slstay=0.5 slentry=0.5 showpvalues;
title "Stepwise Model Selection for SalePrice-SL 0.05";
store out=glmameshousing3forward;
run;