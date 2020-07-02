/* validation data set with data step, hard to get exact percentage of data */
data ameshousing3_train ameshousing3_valid;
set bootcamp.ameshousing3;
random = RAND("Uniform");
if random <=0.2 then output ameshousing3_valid;
else output ameshousing3_train;
run;

/* proc survey select will give you exact percentages */
proc surveyselect data=bootcamp.ameshousing3 method=srs rate=0.2 out=ameshousing3_split outall;
run;

data ameshousing3_train ameshousing3_valid;
set ameshousing3_split;
if selected=1 then output ameshousing3_valid;
else output ameshousing3_Train;
run;