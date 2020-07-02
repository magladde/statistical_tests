proc freq data=stat.ameshousing3;
	tables age_sold /plots=freqplot;
	title "Age sold categorical variable frequency analysis";
run;