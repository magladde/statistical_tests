/* proc reg is best used when all variables are continuous (predictor and response) */
/* by default gives solution for coefficients, has better diagnostics than glm */
proc reg data=bootcamp.ameshousing3;
model saleprice=basement_area lot_area;
title "Model with Basement Area and Lot Area";
run;

/* proc glm can also run multiple linear regressions */
proc glm data=bootcamp.ameshousing3;
model saleprice = basement_area lot_area / solution; /* need to include solution here to get coefficients */
title "Model with Basement Area and Gross Living Area";
run;