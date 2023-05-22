pkg load interval
pkg load optim
addpath(genpath('./tolsolvty'))
addpath(genpath('./ctrsolvty'))
addpath(genpath('./assets'))

infA = [59240 1; 23820 1; 41800 1; 59110 1; 35500 1; 17660 1; 63970 1; 34520 1; 16770 1; 16110 1; 34080 1; 49860 1; 51300 1; 42580 1];
supA = [59348 1; 23924 1; 41912 1; 59228 1; 35618 1; 17772 1; 64086 1; 34630 1; 16880 1; 16228 1; 34196 1; 49978 1; 51412 1; 42696 1];
infb = [399; 416; 408; 397; 406; 417; 390; 405; 418; 420; 414; 401; 398; 407];
supb = [399; 416; 408; 397; 406; 417; 390; 405; 418; 420; 414; 401; 398; 407];
solve2dctrproblem(infA,supA,infb,supb,10e-6,'SW','x','y','Ctr test task','Example_ws');
