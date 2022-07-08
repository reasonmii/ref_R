
dim(data)
str(data)
head(data)

# colnames
names(data)

# Null column change
data[is.na(data$cust_age)] <- 0

colSums(is.na(data))


