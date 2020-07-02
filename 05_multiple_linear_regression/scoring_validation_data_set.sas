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

proc score data=ameshousing3_valid score=Betas out=scored type=parms;
var basement_area lot_area;
run;

data MAPE_v;
set Scored;
AE = abs(Model1 - saleprice);
APE = (abs(model1-saleprice)/saleprice)*100;
run;

proc means data=MAPE_v mean;
var AE APE;
run;

/* you can use proc plm instead of proc score */
proc plm restore=model;
score data = ameshousing3_valid out = Scored;
run;

data MAPE_v;
set Scored;
AE = abs(Model1 - saleprice);
APE = (abs(model1-saleprice)/saleprice)*100;
run;

proc means data=MAPE_v mean;
var AE APE;
run;