# Homework #2
# Author: Kyle Cichos
# Date: 7/5/21


data("iris")
View(iris)

# load packages needed
library(reshape2)
library(dplyr)

iris
iris_stats<-iris %>% group_by(Species) %>% summarise(across(.cols = everything(),list(mean = mean, sd = sd)))
View(iris_stats)

#get data in long format
longiris_stats<-reshape2::melt(iris_stats)
View(longiris_stats)

#variables were renamed in process, must subset them data, rename, and join

#subset
variable<- longiris_stats$variable
longiris_means<- longiris_stats[grep(pattern = "._mean",x = variable),]
longiris_sd<- longiris_stats[grep(pattern = "._sd",x = variable),]
longiris_stats
longiris_means

#rename
longiris_sd
longiris_means<-longiris_means %>% mutate(variable=recode(variable, 
                                                            "Sepal.Length_mean"="Sepal.Length",
                                                            "Sepal.Width_mean"="Sepal.Width",
                                                            "Petal.Length_mean"="Petal.Length",
                                                            "Petal.Width_mean"="Petal.Width"))
longiris_sd<-longiris_sd %>% mutate(variable=recode(variable, 
                                                      "Sepal.Length_sd"="Sepal.Length",
                                                      "Sepal.Width_sd"="Sepal.Width",
                                                      "Petal.Length_sd"="Petal.Length",
                                                      "Petal.Width_sd"="Petal.Width"))

#join
longiris_join<-full_join(x = longiris_means, y = longiris_sd,by = c("Species","variable"))
colnames(longiris_join)[3]= "mean"
colnames(longiris_join)[4]= "sd"
longiris_join


#plotting
ggplot(longiris_join, aes(x=variable,y=mean, fill=Species)) +
  geom_bar(stat="identity", 
           position="dodge", 
           width = 0.9) +
  geom_errorbar(aes(ymin=mean-sd, 
                    ymax=mean+sd, 
                    width=0.4), 
                position=position_dodge(0.9))