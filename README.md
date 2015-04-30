# MicrobeNets
A simple wrapper around glmnet package in R for microbiome data

Background
------

This is a simple script that generates and cross-validates Lasso and Elastic-Net Regularized Generalized Linear Models using a standard OTU table generated via [QIIME 1.8.0 (stable public release)](http://qiime.org/), (in tab-delimited format) as input and standard mapping/metadata file compatible with QIIME.

In the lasso and elastic net models, the OTU counts are treated as explanatory varaibles and the meta-data variable is treated as response variable.

Presently, the script can only perform logistic regression using a meta-data varaible with only two levels. For example, if the 
response variable is temperature in the meta-data mapping file, it must only contain two levels such as High and Low for the script to run. 

Work is in progress to include response variables for more than 2 levels and to create models in which multiple combinations of response variables can be included.

Required R packages
------

- [glmnet](http://cran.r-project.org/web/packages/glmnet/index.html)
- [doMC](http://cran.r-project.org/web/packages/doMC/index.html)
