ods graphics off;
ods select testsforlocation;

proc univariate data=stat.ameshousing3 mu0=135000;
	var SalePrice;
	title "testing whether the mean of sales price = $135K";
run;

ods graphics on;

proc ttest data=stat.ameshousing3 plots(shownull)=interval H0=135000;
	var saleprice;
	title "One-sample t-test testing mean" " Sale price=$135K";
run;