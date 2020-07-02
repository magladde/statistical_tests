proc glm data =bootcamp.MGGarlic_block plots(only)=diagnostics;
class fertilizer sector;
model bulbwt=fertilizer sector;
title "ANOVA for Randomized Block Design";
run;