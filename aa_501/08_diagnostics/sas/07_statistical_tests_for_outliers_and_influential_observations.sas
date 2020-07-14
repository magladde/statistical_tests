/* Defining Categorical Variables */ 
%let categorical=House_Style2 Overall_Qual2 Overall_Cond2 Fireplaces  
         Season_Sold Garage_Type_2 Foundation_2 Heating_QC  
         Masonry_Veneer Lot_Shape_2 Central_Air; 
 
/* Defining Interval Variables */ 
%let interval=Gr_Liv_Area Basement_Area Garage_Area Deck_Porch_Area  
         Lot_Area Age_Sold Bedroom_AbvGr Total_Bathroom; 

data ameshousing_train ameshousing_valid;
set bootcamp.ameshousing3;
call streaminit(12345);
random=RAND("uniform");
if random <= 0.2 then output ameshousing_valid;
else output ameshousing_train;
run;

proc reg data=bootcamp.ameshousing3 plots(unpack)=all;
model saleprice=&interval/influence spec partial;
output out=check r=residual p=pred rstudent=rstudent h=leverage cookd=cookd;
run;
