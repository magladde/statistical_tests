proc univariate data=stat.ameshousing3 noprint;
	var SalePrice;
	histogram saleprice / normal(mu=est sigma=est) kernel;
	inset skewness kurtosis / position=ne;
	probplot saleprice / normal(mu=est sigma=est);
	inset skewness kurtosis;
	title "Descriptive statistics of sales price";
run;