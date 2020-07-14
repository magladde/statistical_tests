data trans;
input obs x y;
datalines;
1 1 21.191 
2 2 24.673 
3 3 32.988 
4 4 33.131 
5 5 33.743 
6 6 51.034 
7 7 31.468 
8 8 66.324 
9 9 55.731 
10 10 43.445 
11 11 36.197 
12 12 30.410 
13 13 69.602 
14 14 56.504 
15 15 85.681 
16 16 61.759 
17 17 41.196 
18 18 83.019 
19 19 160.206 
20 20 115.455 
21 21 27.436 
22 22 79.797 
23 23 108.870 
24 24 62.933 
25 25 113.648 
26 26 81.484 
27 27 108.889 
28 28 165.372 
29 29 134.783 
30 30 111.471 
;

/* qq-plots look pretty good! might be normal */
proc reg data=trans;
model y=x;
output out=check r=residual p=pred;
run;

/* formal test of normality 
null hypothesis is that errors are normally distributed, we want to fail to reject null hypothesis*/
proc univariate data=check normal plots;
var residual;
probplot;
run;

/* if we thought that data was not normally distributed (it is) how would you transform the data to get it normally distrubted? */
/* boxcox transformation works great if you want to add a power to a variable */
/* lambda is power we want to raise our y to 0, 1, 2,.... n */
/* the highest likelihood for this data is 0, labmda=0 means log(y) instead of raising y^0 power */
/* lamda=3 would be y^3 */
/* boxcox show us what power that raising a variable to might make the data normally distributed, might not work */
proc transreg data=trans;
model boxcox(y)=identity(x);
run;

data trans2;
set trans;
logy=log(y);
run;

