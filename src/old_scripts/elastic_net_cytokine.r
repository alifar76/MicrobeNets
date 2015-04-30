# http://stackoverflow.com/questions/17032264/big-matrix-to-run-glmnet
# Cannot use model.matrix for this dataset as we have over 40,000 OTUs to test

rm(list=ls())
require(vegan)
require(glmnet)
require(doMC)
registerDoMC(cores = 4)

selectedVariable <- function(x,y,num,methodtype,compid,outputname){
	fitted = glmnet(x, y,standardize=FALSE,alpha=num)
	plot(fitted, xvar = "lambda", label = TRUE, main=paste("fitted_",compid,"_",methodtype,sep=""))
	print (paste(compid,"_cv_started_",methodtype,sep=""))
	cv.dat = cv.glmnet(x,y,grouped=FALSE,nfolds=length(y),alpha = num,parallel=TRUE)		# lambda=seq(500,0,length.out=100)
	print(paste(compid,"_cv_completed_",methodtype,sep=""))
	plot(cv.dat,main=paste("cv_",compid,"_",methodtype,sep=""))
	coefval <- coef(cv.dat)
	for (i in dimnames(coefval)[[1]]){
		if (coefval[i,] != 0){
			all_dat <- c(compid,methodtype,coefval[i,],i)
			write.table(as.matrix(t(all_dat)),file=outputname,sep=",",row.names=FALSE,col.names=FALSE,quote=FALSE,append=TRUE)
		}
	}
}






workdir <- '/Users/alifaruqi/Desktop/Projects/Development_Tools/Github_Scripts/Elastic_Nets'
setwd(workdir)
otutab <- read.table('high_vs_low_otu_table.txt',header = T, sep = "\t", check.names = T, row.names =1, comment.char= "",skip=1)
MYmetaEF <- read.table('high_low_mapfile.txt',header = T, sep = "\t", check.names = T, row.names =1, comment.char= "")


taxnames <- matrix(nrow=nrow(otutab),ncol=1)
taxnames[,1] <- as.vector(otutab$taxonomy)
rownames(taxnames) <- rownames(otutab)
otutab$taxonomy <- NULL
otutab <- subset(as.matrix(otutab),select=rownames(MYmetaEF))
otutab <- t(otutab)










# All cases
for (i in 1:length(colnames(MYmetaEF))){
	respname <- colnames(MYmetaEF)[i]
	cytok <- subset(MYmetaEF,select=respname)	
	outputname <- paste(respname,"_en_results.csv",sep="")
	selectedVariable(as.matrix(otutab),as.numeric(cytok[,1]),1,"Lasso",respname,outputname)
	selectedVariable(as.matrix(otutab),as.numeric(cytok[,1]),0.5,"EN",respname,outputname)
}