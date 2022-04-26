
# 새로운 변수 정의
# ex) newColumn = column1 / column2
# ★ 주의 : within 함수에서는 새로운 변수 정의 시 반드시 '<-'를 사용해야 함 ('=' X)
within(dataframe, newColumn <- col1 / col2)

# 새로운 변수1을 생성하면서
# 새로운 변수1을 사용한 새로운 변수2도 동시에 생성
within(dataframe, {newColumn1 <- col1 / col2; newColumn2 <- newColumn1 + col2})

