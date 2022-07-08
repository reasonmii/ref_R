
# h2o : Java Virtual Machine's ML/AI
# can check data model on h2o web UI

'''
장점
1) 모델 배포가 편리
   POJO : Plain Old Java Object
2) 확장성이 좋음 (h2o의 클러스터 모드)
3) 모델의 정보를 약간 정리해서 보여준다. (h2o의 UI)

환경 setting
1) java jdk 설치
   java jdk version은 1.7 ~ 1.8
2) 1.6.x 버전의 경우 되기는하지만 소스로 컴파일링 하거나 예전 h2o 버전을 사용해야 함
3) OS의 경우 64 bit를 권장
   32bit인 경우 메모리 사용량이 4GB로 제한되기 때문
   
h2o R Booklet   
https://www.h2o.ai/wp-content/uploads/2018/01/RBooklet.pdf 

h2o grid
http://docs.h2o.ai/h2o/latest-stable/h2o-r/docs/reference/h2o.randomForest.html
'''

install.packages('Rcurl')
install.packages('jsonlite')
install.packages('h2o')

require(h2o)
h2o.init(nthreads = 3,          # CPU를 사용할 thread 개수 지정 (default = -1 : cpu의 thread를 모두 사용)
         max_mem_size = "8g")   # 사용할 메모리의 최대사이즈를 지정 (2MB이상)

data(iris)




