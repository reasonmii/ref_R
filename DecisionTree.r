
# cf1) https://cran.r-project.org/web/packages/rpart.plot/rpart.plot.pdf
# cf2) http://www.milbo.org/rpart-plot/prp.pdf
# cf3) https://www.rdocumentation.org/packages/rpart.plot/versions/3.1.0/topics/rpart.plot

library(rpart)
library(rpart.plot)

tree.fit <- rpart(colY ~ col1 + col2 + col3 + col4, data=data, cp=0.01)
# tree.fit <- rpart(colY ~., data=data, cp=0.01)

# nn=TRUE : Display the node numbers
rpart.plot(tree.fit, box.palette="RdBu", shadow.col="gray", nn=TRUE)

summary(tree.fit)


