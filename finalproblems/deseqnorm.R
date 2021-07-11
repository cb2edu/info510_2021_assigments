#!/usr/bin/env Rscript 
args= commandArgs(TRUE)
file=args[1] #"/data/user/brendon/progbiodata/10-RNASeq/RMD/data/pnas_expression.txt"
setwd("/data/user/brendon/progbiodata/10-RNASeq/RMD")
getwd()
library("DESeq2")
suppressPackageStartupMessages(library(DESeq2))

deseq_counts <- read.table(file, header = T, row.names = 1) # if using args functionality at the command line; ifelse, use following..
#deseq_counts <- read.table("./pnas_expression.txt", header = T, rownames=1)
row.names(deseq_counts) <- deseq_counts$ensembl_ID
deseq_counts <- as.matrix(deseq_counts[,-c(1,ncol(deseq_counts))]) #unique to this data file..
deseq_counts <- deseq_counts[rowSums(deseq_counts) != 0,]
head(deseq_counts)
#generate coldata matrix for deseq object
coldata <- data.frame(condition=c(rep("C",4), rep("T",3)))
row.names(coldata) <- colnames(deseq_counts)
coldata <- as.matrix(coldata)
dds <- DESeqDataSetFromMatrix(countData = deseq_counts, colData = coldata, design = ~ condition)
#estimate size factors for normalization
dds <- estimateSizeFactors(dds)
sizeFactors(dds)
denorm_counts<-counts(dds, normalized=T)
