library(ggplot2)
library(tidyr)
library(dplyr)
data(iris)
means<-lapply(lapply(split.data.frame(iris,iris$Species),isolate_numeric_col),function(x){
  lapply(x,function(x){
    return(c(mean(x),sd(x)))
  })
})
means_df<-lapply(means,as.data.frame)
names_df<-lapply(means_df,"rownames<-",c("Mean","Standard_Deviation"))
g_df<-lapply(names_df, function(x){
  temp1<-gather(x[1,])
  temp2<-gather(x[2,])
  temp3<-inner_join(temp1,temp2, by = c("key"))
  names(temp3)<-c("Attribute","Mean","Standard_Deviation")
  temp3<-temp3[,c(2,3,1)]
  return(temp3)
})
#Wish there was a way I could set df name as a variable
g_df$setosa$Species<-c("setosa")
g_df$versicolor$Species<-c("versicolor")
g_df$virginica$Species<-c("virginica")
comb_stats<-do.call(rbind, g_df)
rownames(comb_stats)<-NULL
comb_stats$Attribute<-as.factor(comb_stats$Attribute)
comb_stats$Species<-as.factor(comb_stats$Species)
comb_stats
g1<-ggplot(comb_stats, aes(x=Attribute, y=Mean,fill=Species))+geom_bar(stat="identity",position = "dodge")+geom_errorbar(aes(ymin=Mean-Standard_Deviation, ymax=Mean+Standard_Deviation),position="dodge")
g2<-ggplot(comb_stats, aes(x=Species, y=Mean,fill=Attribute))+geom_bar(stat="identity",position = "dodge")+geom_errorbar(aes(ymin=Mean-Standard_Deviation, ymax=Mean+Standard_Deviation),position="dodge")
g1
g2
