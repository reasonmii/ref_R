# Row

data_a <- data[age <= 30]
data_b <- data[age > 30]

data_a <- subset(data, age<=30)
data_b <- subset(data, age>30)

# Column

data <- subset(data, base_yymm >= '201701')
