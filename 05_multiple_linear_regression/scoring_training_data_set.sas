/* proc survey select will give you exact percentages */
proc surveyselect data=bootcamp.ameshousing3 method=srs rate=0.2 out=ameshousing3_split outall;
run;

data ameshousing3_train ameshousing3_valid;
set ameshousing3_split;
if selected=1 then output ameshousing3_valid;
else output ameshousing3_Train;
run;

proc reg data=ameshousing3_train outest=Betas;
model saleprice=basement_area lot_area;
output out=scored predicted=pred;
store out = model;
run;

data MAPE_t;
set scored;
AE = abs(pred - saleprice);
APE = (abs(pred-saleprice) / saleprice)*100;
run;

proc means data=MAPE_t mean;
var AE APE;
run;