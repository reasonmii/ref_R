
# Imbalanced Data

install.packages("ROSE")
library(ROSE)

data(cars)
head(data)

# Check the original variable
addmargins(table(data$hd))
prop.table(table(data$hd))

# N refers to the final number of the total data after sampling

# Over sampling
dataOS <- ovun.sample(hd ~., data = data, method = "over", N = 500)$data
addmargins(table(dataOS$hd))
          
# Under sampling
dataUS <- ovun.sample(hd ~., data = data, method = "under", N = 200)$data
addmargins(table(dataUS$hd))

# both under and over sampling
# minority class is oversampled with replacement
# majority class is undersampled without replacement
databa <- ovun.sample(hd ~., data = data, method = "both", p = 0.5, N = 500, seed = 123)$data
addmargins(table(data$hd))





