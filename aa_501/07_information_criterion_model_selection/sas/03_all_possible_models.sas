%let interval=Gr_Liv_Area Basement_Area Garage_Area Deck_Porch_Area Lot_Area Age_Sold Bedroom_AbvGr Total_Bathroom;
ods graphics on;
%let categorical=House_Style2 Overall_Qual2 Overall_Cond2 Fireplaces Season_Sold Foundation_2 Heating_QC Masonry_Veneer Lot_Shape_2 Central_Air;


/*************************************************************/
proc reg data=stats.ameshousing3_train plots=all;
  ALLPOSS: model SalePrice=&interval/selection=rsquare adjrsq cp;
  title "All possible model selection for SalePrice";
run;
quit;


/* Best subsets in proc reg (proc glmselect does not have this yet)  */
proc reg data=stats.ameshousing3_train plots=cp;
  ALLPOSS: model SalePrice=&interval/selection=cp best=3;
  title "All possible model selection for SalePrice";
run;
quit;

/* ******************************************************* */