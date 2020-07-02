proc means data=stat.ameshousing3 maxdec=2 n mean std stderr clm;
	var SalePrice;
	title "95% confidence interval for sales price";
run;