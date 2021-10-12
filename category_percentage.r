
# ---------------------------------------------------------------------
# lapply vs do.call
#
# lapply
# 1) 인수로 받은 함수를 인수로 받은 리스트의 각각의 인덱스에 하나하나 적용
# 2) 인수로 받은 함수를 인덱스의 요소만큼 실행

# do.call
# 1) 인수로 받은 함수를 리스트의 인덱스 전체에 적용
# 2) 한번만 실행
# ---------------------------------------------------------------------

library(dplyr)

# Calculate the total number of each category
# Category1 : sex (female, male, etc)
# Category2 : seg (churn, change)

cnt <- data %>%
  group_by(sex, seg) %>%
  summarise(n=n())

# Calculate the percentage of category2 in category1
# ex) female = churn + change = 100%


# ---------------------------------------------------------------------
# Percentage of 'churn' customers in each category (female, male, etc)
# ---------------------------------------------------------------------

pcnt1 <- do.call(rbind,
                 lapply(split(cnt, cnt$sex), function(x){x[x$seg=='churn', 'n']/sum(x$n)}))

# Change the column's name to 'pcnt'
names(pcnt1) <- 'pcnt'

# Add column called category1, 'sex'
pcnt1$sex <- rownames(pcnt1)

# Add column called category2, 'seg'
pcnt1$seg <- 'churn'


# ---------------------------------------------------------------------
# Percentage of 'change' customers in each category (female, male, etc)
# ---------------------------------------------------------------------

pcnt2 <- do.call(rbind,
                 lapply(split(cnt, cnt$sex), function(x){x[x$seg=='change', 'n']/sum(x$n)}))

# Change the column's name to 'pcnt'
names(pcnt2) <- 'pcnt'

# Add column called category1, 'sex'
pcnt2$sex <- rownames(pcnt2)

# Add column called category2, 'seg'
pcnt2$seg <- 'change'


# ---------------------------------------------------------------------
# Merge
# ---------------------------------------------------------------------

mg <- rbind(pcnt1, pcnt2)

