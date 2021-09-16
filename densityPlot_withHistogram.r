
temp_dt = data[, c('age', 'tenure')]

x = temp_dt[[1]]
y = temp_dt[[2]]

xName = 'age'
yName = 'tenure'

plotDT <- data.table(X=x, Y=y)
statDT <- plotDT[ , .(MIN = min(X),
                      Q1 = quantile(X, 0.25),
                      MEDIAN = as.numeric(median(X)),
                      Q3 = quantile(X, 0.75),
                      MAX = max(X),
                      MEAN = mean(X),
                      SD = sd(x))
                  , by = Y]

# Density Plot with Histogram Overlapped
# ★ position="identity"overlaps the bar, and the default option is position="stack"
ggplot(plotDT, aes(x=X, fill=Y))+
  geom_histogram(aes(y=..density..), bins=30, alpha=.5, position="identity")+
  scale_x_continuous()+
  geom_density(alpha=.3)+
  labs(x = toupper(xName), y="Density", fill=toupper(yName),
       title = sprintf("%s Density by %s", toupper(xName), toupper(yName)),
       subtitle = sprintf("P(%s | %s) - Displayed by Original Scale", toupper(xName), toupper(yName)))+
  theme_bw()+
  theme(plot.title=element_text(size=12))+
  theme(plot.subtitle=element_text(size=9, color="blue"))


statRes <- cbind(xName, statDT)

