
# Install package
# install.packages("ggplot2")
# if (!requireNamespace("BiocManager", quietly = TRUE))
#   install.packages("BiocManager")
# BiocManager::install("DESeq2")
# 
# install.packages("cowplot")
#

getwd()
dir()

# Load pnas_expression data with rownames as gene name (ensembl_ID)
pnasData <- read.table("pnas_expression.txt", header = T, row.names=1, stringsAsFactors=FALSE)
dim(pnasData)
head(pnasData)

# Remove the columns 8 and keep the Rows whose sum of all column not equals zero
pnasData <- data_pnas[rowSums(pnasData[,-8])>0,-8]
dim(pnasData)
head(pnasData)

#-------------------------------------------------------------------------------
# Perform Upper quantile normalization
#-------------------------------------------------------------------------------
pnas_uq <- apply(pnasData, 2, function(x){quantile(pnasData[pnasData>0], 0.75)})
pnas_uq_normalized <- t(t(pnasData) / pnas_uq)
dim(pnas_uq_normalized)
head(pnas_uq_normalized)

#-------------------------------------------------------------------------------
# Perform Deseq normalization
#-------------------------------------------------------------------------------
suppressPackageStartupMessages(library(DESeq2))

# Let us use the above 'pnasData' 

coldata <- data.frame(condition=c(rep("C",4), rep("T",3)))
dim(coldata)
head(coldata)
row.names(coldata) <- colnames(pnasData)
head(coldata)

# Create dataset in DSeq2
dds <- DESeqDataSetFromMatrix(countData = pnasData, colData = coldata, design = ~ condition)
dds <- estimateSizeFactors(dds)
sizeFactors(dds)

# Get the normalized dataset
pnas_deseq_normalized <- counts(dds, normalized=T)

#-------------------------------------------------------------------------------
# Box Plot
#-------------------------------------------------------------------------------

library(dplyr)
library(tidyr)
library(ggplot2)
# This function takes data frame and draw Box Plot using ggplot2
plot_ggboxPlot  <-  function(data, title, yName, ymax){
  p <- ggplot(data, aes(x = key, y = value)) + 
    geom_boxplot(fill = "#4271AE", colour = "#1F3552", alpha = 0.6, outlier.shape=NA)  +
    labs(x="")  +
    scale_y_continuous(name=yName, limits=c(0, ymax)) +
    ggtitle(title) +
    theme(plot.title = element_text(hjust = 0.5))
  
  p
}

# Log2 transformation of raw data 
log_pnasData <- log2(pnasData +1)

# convert Upper quantile normalized data (matrix) to data Frame
pnas_uq_normalized_data  <- as.data.frame(apply(pnas_uq_normalized, 2, unlist))
# Log2 transformation of Upper quantile normalized data
log_pnas_uq_normalized_data <- log2(pnas_uq_normalized_data +1)

# convert DeSeq normalized data (matrix) to data Frame
pnas_deseq_normalized_data  <- as.data.frame(apply(pnas_deseq_normalized, 2, unlist))
# Log2 transformation of DeSeq normalized data
log_pnas_deseq_normalized_data <- log2(pnas_deseq_normalized_data +1)

# Create ggplot object 

library(dplyr)
p_raw <- plot_ggboxPlot(gather(log_pnasData), "Before normalization", "Log2(Read counts)", 15)
p_uq <- plot_ggboxPlot(gather(log_pnas_uq_normalized_data), "After upper quartile normalization","Log2(Read counts)", 4)
p_deseq <- plot_ggboxPlot(gather(log_pnas_deseq_normalized_data), "After DESEQ normalization", "Log2(Read counts)", 15)

# Draw the ggplot objects in grid
library(cowplot)
plot_grid(p_raw, p_uq,p_raw, p_deseq, ncol = 2, nrow = 2)


