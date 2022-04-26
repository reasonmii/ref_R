
# 새로운 변수 정의
# ex) newColumn = column1 / column2
# ★ 주의 : within 함수에서는 새로운 변수 정의 시 반드시 '<-'를 사용해야 함 ('=' X)
within(dataframe, newColumn <- col1 / col2)

# 새로운 변수 여러 개 정의
within(dataframe, {newColumn1 <- col1 / col2; newColumn2 <- col1 + col2})

