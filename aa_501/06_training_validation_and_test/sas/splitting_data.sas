/* using proc survey select */
proc surveyselect data=bootcamp.ameshousing3 seed =12345 out=ames3temp groups=(240 60);
run;

/* separate training and validation data */
data ames_training;
set ames3temp;
if groupid=1;
run;

data ames_validation;
set ames3temp;
if groupid=2;
run;

/* Create data sets using the data step */
data ames_training ames_validation;
set bootcamp.ameshousing3;
call streaminit(12345);
random=RAND("Uniform");
if random <= 0.2 then output ames_validation;
else output ames_training;
run;