/* Defining Categorical Variables */ 
%let categorical=House_Style2 Overall_Qual2 Overall_Cond2 Fireplaces  
         Season_Sold Garage_Type_2 Foundation_2 Heating_QC  
         Masonry_Veneer Lot_Shape_2 Central_Air; 
 
/* Defining Interval Variables */ 
%let interval=Gr_Liv_Area Basement_Area Garage_Area Deck_Porch_Area  
         Lot_Area Age_Sold Bedroom_AbvGr Total_Bathroom; 

/* Exploratory data analysis */
/* Scatter Plots of Continuous Variables */
proc sgscatter data=bootcamp.ameshousing3;
plot saleprice*gr_liv_area / reg;
title "Associations of Above Grade Living Area with Sale Price";
label gr_liv_area="Greater Living Area";
run;

/* Scatter Plots of All/Multiple Continuous Variables with Target */
proc sgscatter data=bootcamp.ameshousing3;
plot saleprice*(&interval) / reg;
title "Associations of Interval Variables with Sale Price";
run;

/* Box Plots of Categorical Variables */
proc sgplot data=bootcamp.ameshousing3;
vbox saleprice / category=central_air connect=mean;
title "Sale price differences across central air";
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
