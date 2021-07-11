# Homework Final Problem
# Author: Kyle Cichos
# Date: 7/10/21

# Problem 2(A)

#!/usr/bin/env Rscript
# args= commandArgs(TRUE)
# file=args[1]        #"/data/user/kyle/INFO710/10-RNASeq/RMD/data/pnas_expression.txt"
# setwd("/data/user/kyle/INFO710/10-RNASeq/RMD")
# getwd()
# raw.data <- read.table(file,header=T, row.names = 1)
# this is the functionality I would write if using commandArgs, I did not use that in my initial work though so I have copied my work below:

# Upper Quantile Normalization
raw.data <- read.table("./pnas_expression.txt",header=T, row.names = 1)
raw.data
counts <- raw.data[ , -c(ncol(raw.data))]
head(counts)

zero_counts<- apply(counts, MARGIN =1, FUN = sum)   #remove all rows with total counts <5
zero_counts <- zero_counts > 5
counts <- counts[zero_counts,]

head(counts)
uqn <- apply(counts, MARGIN = 2, function(x) quantile(x, probs=.75))
uqn
normal_c<-sweep(counts, 2, uqn, FUN = "/")
head(normal_c)
normal_c<-normal_c*1000      #scale up 1000x
head(normal_c)
