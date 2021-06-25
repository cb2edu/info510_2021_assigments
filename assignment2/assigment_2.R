
# library
library(ggplot2)
library(viridis)
library(hrbrthemes)

# data preparation
collapsed_iris <- gather(iris, key="key", value="value", -Species)
head(collapsed_iris)

p1=aggregate(x = collapsed_iris$value , by =list(collapsed_iris$key, collapsed_iris$Species), FUN = mean)

p2=aggregate(x = collapsed_iris$value , by =list(collapsed_iris$key, collapsed_iris$Species), FUN = sd)
p2
p1$sd <- p2$x
p1
names(p1) <- c("measurement", "Species","mean","sd")
p1

# Graph
ggplot(p1, aes(fill=Species, y=mean, x=Species)) + 
  geom_bar(position="dodge", stat="identity") +
  geom_errorbar(aes(ymin = mean-sd, ymax=mean+sd, width = 0.2)) +
  scale_fill_viridis(discrete = T, option = "E") +
  ggtitle("Studying 3 species..") +
  facet_wrap(~measurement) +
  theme_ipsum() +
  theme(legend.position="none") +
  xlab("")

## reference 1 https://www.r-graph-gallery.com/48-grouped-barplot-with-ggplot2.html
## reference 2 https://www.geeksforgeeks.org/how-to-calculate-the-mean-by-group-in-r-dataframe/


