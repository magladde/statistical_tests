proc glm data=stat.ameshousing3 order=internal;
	class season_sold heating_QC;
	model saleprice=heating_QC season_sold;
	lsmeans season_sold / diff adjust=tukey;
	format season_sold season.;
	title "Model with Heating Quality and Season as Predictors";
	run;