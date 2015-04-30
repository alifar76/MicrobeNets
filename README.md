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

Running the script
------

There is 1 script in the folder src. The one to use is called ```elastic_net_lasso_script.r```. The script is run via command line using the Rscript command (in terminal). There is 1 script in the folder old_scripts but it can be ignored as it is just an older version, saved for trouble-shooting.

To run the script, pass the command in following format:

```Rscript elastic_net_lasso_script.r high_vs_low_otu_table.txt high_low_mapfile.txt en_lasso_output.csv auc binomial 4```

As seen from the command, the script takes in 6 commands. They are as follows:

1) OTU table generated via QIIME (which is called **high_vs_low_otu_table.txt** in the above example)

2) QIIME compatible mapping file (which is called **high_low_mapfile.txt** in the above example)

3) Name of the result/output file produced by the script (which is called **en_lasso_output.csv** in the above example)

4) Loss to use for cross-validation (which is called **auc** in the above example). This is an argument for the function, [cv.glmnet](http://www.inside-r.org/packages/cran/glmnet/docs/cv.glmnet). It corresponds to the ```type.measure``` argument.  For two-class logistic regression only, as implemented in this script, ```auc``` can be used. For more details about this argument, read the [documentation](http://www.inside-r.org/packages/cran/glmnet/docs/cv.glmnet).

5) Family of probability distribution describing response type (which is called **binomial** in the above example). This is an argument for the [glmnet](http://www.inside-r.org/packages/cran/glmnet/docs/glmnet) function.
If the responsve variable is a factor with two levels, ```binomial``` can be used. For more details about this argument, read the [documentation](http://www.inside-r.org/packages/cran/glmnet/docs/glmnet).

6) No. of cores to use. More cores on machine, faster the analysis will complete (which is **4** in the above example)

Please ensure that all the 8 arguments are provided, in the correct order and format. Otherwise, the script will crash and cause problems.

Input file format
------

Input of file format should be one compatabile with QIIME. However, please ensure that the sample IDs are not numeric. That is, the sample IDs should not be like: 1560.1, 1561.1, 1559.1, etc. If such is the case, please slightly modify the sample IDs in both the mapping file and OTU table by adding any alphabet. So, for example, sample ID 1560.1 will become p1560.1.

Also, please make sure that the mapping file has the same number of samples as the OTU tables, having the same sample IDs. If mapping file has more or less sample IDs than the samples in the OTU table, the script will crash.

Output Explained
------

