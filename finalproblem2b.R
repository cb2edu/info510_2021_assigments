# Homework Final Problem
# Author: Kyle Cichos
# Date: 7/10/21

# Problem 2 (B)

head(counts)
head(normal_c)
head(dscounts)

#load packages and libraries needed
install.packages("ggpubr")
library(ggpubr)

library(tidyr)
library(ggplot2)

g1<- ggplot(gather(counts), aes(x=key, y=value)) + 
  stat_boxplot(geom ='errorbar')+
  geom_boxplot()+
  coord_cartesian(ylim = c(0, 250)) +
  ggtitle("Before Upper Quantile Normalization") +
  xlab("Sample") + ylab("Reads per Gene") +
  theme(plot.title = element_text(color="black", size=14, face="bold.italic", hjust = .5))
g1

g2<- ggplot(gather(counts), aes(x=key, y=value)) + 
  stat_boxplot(geom ='errorbar')+
  geom_boxplot()+
  coord_cartesian(ylim = c(0, 250)) +
  ggtitle("Before DEseq Normalization") +
  xlab("Sample") + ylab("Reads per Gene")+
  theme(plot.title = element_text(color="black", size=14, face="bold.italic", hjust = .5))
g2

g3 <-ggplot(gather(normal_c), aes(x=key, y=value)) + 
  stat_boxplot(geom ='errorbar')+
  geom_boxplot()+
  coord_cartesian(ylim = c(0, 2700))+
  ggtitle("After Upper Quantile Normalization") +
  xlab("Sample") + ylab("Reads per Gene")+
  theme(plot.title = element_text(color="black", size=14, face="bold.italic", hjust = .5))
g3

g4 <-ggplot(gather(as.data.frame(denorm_c)), aes(x=key, y=value)) +stat_boxplot(geom ='errorbar')+
  geom_boxplot()+
  coord_cartesian(ylim = c(0, 150)) +
  ggtitle("After DEseq Normalization") +
  xlab("Sample") + ylab("Reads per Gene")+
  theme(plot.title = element_text(color="black", size=14, face="bold.italic", hjust = .5))
g4

pub_figure1 <- ggarrange(g1, g2, g3, g4,
                    ncol = 2, nrow = 2)
pub_figure1




