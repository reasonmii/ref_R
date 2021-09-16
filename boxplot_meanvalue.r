
library(tidyverse)
library(hrbrthemes)  # theme_ipsum()
library(viridis)

# To show the 'mean' value on the boxplot
# round
fun_mean <- function(x){return(round(data.frame(y=mean(x), label=mean(x, na.rm=T)), 2))}

data %>%
  ggplot(aes(x=sex, y=tenure/365, fill=sex))+
  # geom_violin()+
  geom_boxplot()+
  scale_fill_viridis(discrete=TRUE, alpha=0.6, option="A")+
  # mean point
  stat_summary(fun.y=mean,
               geom="point",
               col="black",
               shape=18,
               size=3)+
  stat_summary(fun.data=fun_mean,
               geom="text",
               # text move to the right
               hjust=-0.7)+
  theme_ipsum()+
  theme(legend.position="none",
        plot.title=element_text(size(11))+
  ggtitle("Gender & Tenure")+
  xlab("Gender")+
  ylab("Tenure")

