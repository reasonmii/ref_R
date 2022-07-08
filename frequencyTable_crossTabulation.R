

''' ◆ ftable( )
2차원 교차표일 경우 table( )함수와 비슷한 결과값
3차원 이상일 경우에는 table( )함수보다 유용한 결과를 얻을 수 있는 함수

ftable( ….., exclude = c(NA, NaN), row, vars = NULL, col.vars = NULL)
- …. : 교차표를 생성할 수 있는 R의 객체
      (벡터, 데이터프레임, table함수를 이용하여 얻은 결과값)
- exclude : 각 변수에서 제외할 값
- row.vars : 행에 사용할 변수의 번호 또는 변수명
- col.vars : 열에 사용할 변수의 번호 또는 변수명
'''

data(mtcars)

### vs와 gear에 대한 교차표
ftable(vs~gear, data=mtcars)     # method1
ftable(mtcars$gear, mtcars$vs)   # method2


# 세 개의 열에 대한 교차표
ftable(mtcars[,8:10], row.vars = 2)
ftable(mtcars[,8:10], col.vars = 2)



''' ◆ prop.table( )
도수분포표, 교차표의 상대도수 값을 얻기 위하여 이용

prop.table(x, margin = NULL)
- x : table, ftable 함수를 이용하여 얻는 도수분포표 또는 교차표
- margin : 상대도수를 계산할 때, 분모로 사용할 변수를 지정
           NULL : 전체 합에 대한 상대도수
           1 : 첫 번째 변수(행)에 대한 상대도수
           2 : 두 번째 변수(열)에 대한 상대도수
'''

prop.table(table(mtcars$gear, mtcars$carb))
sum(prop.table(table(mtcars$gear, mtcars$carb)))

prop.table(table(mtcars$gear, mtcars$carb), margin = 1)
sum(prop.table(table(mtcars$gear, mtcars$carb), margin = 1)[1,])

prop.table(table(mtcars$gear, mtcars$carb), margin = 2)
sum(prop.table(table(mtcars$gear, mtcars$carb), margin = 2)[,1])



''' ◆ addmargins( )
행, 열 총합 계산

addmargins(A, margin = seq_along(dim(A)), ….)
- A : table( ), ftable( ), prop.table( )의 결과값을 설정
'''

addmargins(table(mtcars$gear, mtcars$carb))
addmargins(prop.table(table(mtcars$gear, mtcars$carb)))

