proc ttest data=stat.ameshousing3 plots(showh0)=interval;
	class masonry_veneer;
	var saleprice;
	format masonry_veneer $NoYes.;
	title "two sample t-test Comparing Masonry Veneer, No vs. Yes";
run;