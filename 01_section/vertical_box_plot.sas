proc sgplot data=stat.ameshousing3;
	vbox saleprice/ datalabel=Overall_qual;
	refline 135000/ axis=y label;
	title "Box plots of sales prices";
run;