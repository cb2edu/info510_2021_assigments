#!/usr/bin/env Rscript
args= commandArgs(TRUE)
file=args[1] #"/data/user/brendon/progbiodata/10-RNASeq/RMD/data/pnas_expression.txt"
setwd("/data/user/brendon/progbiodata/10-RNASeq/RMD")
getwd()
raw.data <- read.table(file,header=T, row.names = 1) # if using args functionality at the command line; ifelse, use following..
# raw.data <- read.table("./pnas_expression.txt",header=T, row.names = 1)
raw.data
counts <- raw.data[ , -c(ncol(raw.data))] #unique to this data file..
head(counts)
#remove all the rows with total counts < 5.
zerocounts<- apply(counts, MARGIN =1, FUN = sum)
zerocounts <- zerocounts > 5
counts <- counts[zerocounts,]

head(counts)
uqn <- apply(counts, MARGIN = 2, function(x) quantile(x, probs=.75))
uqn
normalized_c<-sweep(counts, 2, uqn, FUN = "/")
head(normalized_c)
#scale up 1000x, to avoid having fractional values 
normalized_c<-normalized_c*1000
head(normalized_c)
