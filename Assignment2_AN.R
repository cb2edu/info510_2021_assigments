

#Bar plot assignment
library(ggpubr)
library(RColorBrewer)

#use the "gather" function to merge the 4 numerical variable columns into a single column, while keeping the Species column (categorical variable) seperate
g_iris <- gather(iris, Sepal.Length, Sepal.Width, Petal.Length,Petal.Width, key = "att",value = "val")
head(g_iris)

#Step1
ggbarplot(g_iris,x="att", y="val",add = "mean_sd", fill="Species")

#Step2
ggbarplot(g_iris,x="att", y="val",add = c("mean_sd","jitter"), color = "Species",position = position_dodge(0.8), palette = "Set1")

#FInal grouped barplot with error bars and jitter for groups and sub-groups
ggbarplot(g_iris,x="att", y="val",add = c("mean_sd","jitter"),add.params = list(shape = "Species"), fill = "Species", palette = "Set1",position = position_dodge(0.8))











