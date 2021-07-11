# Homework Final Problem
# Author: Kyle Cichos
# Date: 7/10/21

# Problem 2 (A) Cont.


#!/usr/bin/env Rscript
# args= commandArgs(TRUE)
# file=args[1]        #"/data/user/kyle/INFO710/10-RNASeq/RMD/data/pnas_expression.txt"
# setwd("/data/user/kyle/INFO710/10-RNASeq/RMD")
# getwd()
# deseq_counts <- read.table(file, header = T, row.names = 1)
# Again, this is the functionality I would write if using commandArgs, I did not use that in my initial work though so I have copied my work below:

# DESEQ Normalization
library(DESeq2)
suppressPackageStartupMessages(library(DESeq2))

dscounts <- read.table("./pnas_expression.txt", header = T, rownames=1)
row.names(dscounts) <- dscounts$ensembl_ID
dscounts <- as.matrix(dscounts[,-c(1,ncol(dscounts))])
dscounts <- dscounts[rowSums(dscounts) != 0,]
head(dscounts)

coldata <- data.frame(condition=c(rep("C",4), rep("T",3)))
row.names(coldata) <- colnames(dscounts)
coldata <- as.matrix(coldata)
dds <- DESeqDataSetFromMatrix(countData = dscounts, colData = coldata, design = ~ condition)

dds <- estimateSizeFactors(dds)
sizeFactors(dds)
denorm_c<-counts(dds, normalized=T)