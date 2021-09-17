# Create count matrix
data <- table(data[ , c("column1", "column2")])

# Select matrix
data[1:11, 12:22]

# Plot correlations
library(corrplot)

dataC <- cor(data)

corrplot(dataC,
         is.corr = FALSE,
         method = "shade",
         addCoef.col = "black")   # corr number's color
