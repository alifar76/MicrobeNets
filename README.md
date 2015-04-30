# MicrobeNets
A simple wrapper around glmnet package in R for microbiome data

Background
------

This is a simple script that generates and cross-validates Lasso and Elastic-Net Regularized Generalized Linear Models using a standard OTU table generated via
[QIIME 1.8.0 (stable public release)](http://qiime.org/), (in tab-delimited format) as input and standard mapping/metadata file compatible with QIIME.

In the lasso and elastic net models, the OTU counts are treated as explanatory varaibles and the meta-data variable is treated as response variable.

Presently, the script can only perform a single category comparison for variables. For example, if the metadata have two
variables such as diet and antibiotic exposure, the script will have to be run seperately for each variable. A joint model
including both explanatory variables (i.e., diet and antibiotic exposure) cannot be currently calculated.

Furthermore, the script can only work with variables that that have two levels. For example, if the 
explanatory variable is temperature, it must only contain two levels such as High and Low for the script to run. 

Work is in progress to include comparisons for more than 2 levels and to create models in which multiple combinations of explanatory variables can be included.

Required R packages
------

- [glmnet](http://cran.r-project.org/web/packages/glmnet/index.html)
- [doMC](http://cran.r-project.org/web/packages/doMC/index.html)
