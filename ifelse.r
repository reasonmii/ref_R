
data$newCol <- ifelse(data$colName < 60,
                      ifelse(data$colName < 40,
                             ifelse(data$colName < 20, "20↓", "20↑"), "40↑"), "60↑")


