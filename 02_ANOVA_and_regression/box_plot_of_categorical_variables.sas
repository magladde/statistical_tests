/* Defining Categorical Variables */
%let categorical=House_Style Overall_Qual Overall_Cond Year_Built 
         Fireplaces Mo_Sold Yr_Sold Garage_Type_2 Foundation_2 
         Heating_QC Masonry_Veneer Lot_Shape_2 Central_Air;

/* Defining Interval Variables */
%let interval=SalePrice Log_Price Gr_Liv_Area Basement_Area 
         Garage_Area Deck_Porch_Area Lot_Area Age_Sold Bedroom_AbvGr 
         Full_Bathroom Half_Bathroom Total_Bathroom ;

/* Box plot between two categorical variables */
proc sgplot data=stat.ameshousing3;
vbox saleprice / category=central_air connect=mean;
title "Sale Price differences across central air";
run;

/****************************************************************/ 
/****** MACRO for Box Plots of ALL Categorical Variables ********/ 
/*  Macro scripting is part of the ADVANCED SAS certification   */ 
/* Code like this will NOT be expected on the summer assessment */ 
/****************************************************************/ 
 
%macro box(dsn      = , 
           response = , 
           Charvar  = ); 
%let i = 1 ; 
%do %while(%scan(&charvar,&i,%str( )) ^= %str()) ; 
 
    %let var = %scan(&charvar,&i,%str( )); 
 
    proc sgplot data=&dsn; 
        vbox &response / category=&var  
                         grouporder=ascending  
                         connect=mean; 
        title "&response across Levels of &var"; 
    run; 
 
    %let i = %eval(&i + 1 ) ; 
%end ; 
%mend box; 
 
%box(dsn      = public.ameshousing3, 
     response = SalePrice, 
     charvar  = &categorical); 