
# 중복 없이 개수 세기
sum(!duplicated(data$userid))
sum(!duplicated(data[,c("userid")]))

# 중복된 행 : TRUE 반환
# 중복X 행 : FALSE 반환

x
#    column1   column2
# 1     a        1
# 2     c        3
# 3     a        1
# 4     b        2
# 5     b        5
# 6     c        3
# 7     d        4

duplicated(x)
# [1] FALSE FALSE TRUE FALSE FALSE TURE FALSE

which(duplicated(x))
# [1] 3 6
# 3행과 6행이 중복이라는 의미

x[which(duplicated(x)),]
#    column1   column2
# 3     a        1
# 6     c        3

# 중복된 최초의 행까지 포함하기
# duplicated(x) : 맨 위부터 중복 여부 검사 (default)
# fromLast=T : 끝에서부터 중복 여부를 검사해라
x[which(duplicated(x) | duplicated(x, fromLast=T),]
