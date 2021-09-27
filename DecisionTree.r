
library(rpart)
library(rpart.plot)

tree.fit <- rpart(colY ~ col1 + col2 + col3 + col4, data=data, cp=0.01)
# tree.fit <- rpart(colY ~., data=data, cp=0.01)

rpart.plot(tree.fit, box.palette="RdBu", shadow.col="gray", nn=TRUE)

summary(tree.fit)


