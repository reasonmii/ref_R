library(ggplot2)

# x : churn rate
# y : dissatisfied call rate
# Apply different color by chanel

ggplot(data = dataOrg, aes(x=can, y=vcall, colour=chanel))+
  # shape = 15 : square / 16 : circle / 17 : triangle
  geom_point(shape=19, size=2)+
  facet_wrap(~chanel)+                                 # 정사각형 될 수 있게 레벨1에 따라 subplot 그리기
  #facet_grid(chanel~.)+                               # 레벨1에 따라 subplot으로 그래프 분리
  stat_smooth(method=lm, se=FALSE, color = 'black')+   # Trend line
  scale_x_continuous(limits = c(0, 0.025))+            # x-axis range
  scale_y_continuous(limits = c(0, 0.025))+            # r-axis range
  ggtitle("The Relationship between TWO")+
  xlab("Churn rate")+
  ylab("Dissatisfied call rate")
