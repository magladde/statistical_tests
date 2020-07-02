proc means data=stat.ameshousing3 printalltypes;
	class House_Style;
	var SalePrice;
	title "Descriptive Statistics by House Style";
run;