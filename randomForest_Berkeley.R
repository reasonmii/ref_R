

data(iris)
summary(iris)
head(iris)

install.packages("randomForest")
library(randomForest)

iris.rf <- randomForest(iris[,-5], iris[,5], prox = TRUE)
iris.p <- classCenter(iris[,-5], iris[,5], iris.rf$prox)     # median
plot(iris[,3], iris[,4],
     pch = 21,
     xlab = names(iris)[3],
     ylab = names(iris)[4],
     bg = c("red", "blue", "green")[as.numeric(factor(iris$Species))],
     main = "Iris Data with Prototypes")
points(iris.p[,3], iris.p[,4], pch = 21, cex = 2, bg = c("red", "blue", "green"))


###
rf1 <- randomForest(Species ~ ., iris, ntree=50, norm.votes=FALSE)
rf2 <- randomForest(Species ~ ., iris, ntree=50, norm.votes=FALSE)
rf3 <- randomForest(Species ~ ., iris, ntree=50, norm.votes=FALSE)
rf.all <- combine(rf1, rf2, rf3)
print(rf.all)










