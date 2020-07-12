class(iris) # iris 데이터의 종류가 무엇인지?
head(iris)
dim(iris)  
table(iris$Species) # Species 열의 정보만 요약해서

# 단순히 어떤 그룹이 있는지만 알아보려면
unique(iris$Species)

# 자료구조가 data frame이면 열 데이터를 추출할때 iris$Species가 가능
# 만일. iris가 matrix이면 iris[,5], iris[,"Species"] 처럼 해야 한다.

summary(iris[,1]) # Sepal.Length, 꽃잎의 길이에 대한 총 데이터(150개의 데이터)
summary(iris[,2])
summary(iris[,"Petal.Length"]) # [,3]
summary(iris$Petal.Width) # [,4]와 동일

#sd 표준 편차
sd(iris[,1]) # Sepal.Length의 150개 데이터의 표준편차
sd(iris[,2]) # 꽃잎의 너비의 150개 값의 표준 편차
sd(iris[,3]) # 꽃받침의 길이
sd(iris[,4]) #꽃받침의 너비

#2열 Sepal.Width는 데이터의 편차가 작고, 3열 Petal.Length는 편차가 크다


par(mfrow = c(2,2)) #2행 2열 데이터 형태 만들어 조각내는 명령 , partition
boxplot(Sepal.Length~Species, data = iris, # Species가 x 축 ,Sepal_Length가 y축
        main = "Sepal.Length")
boxplot(Sepal.Width~Species, data = iris,
        main = "Sepal.Width")
boxplot(Petal.Length~Species, data = iris,
        main = "Petal.Length")
boxplot(Petal.Width~Species, data = iris,
        main = "Petal.Width")


# ~ 앞이 y축, 뒤가 x 축 
# 예제 해석
# 4개의 변수에서 각 그룹간 데이터의 크기는 차이가 존재한다.
# Sepal.Width와 Sepal.Length에서는 그룹간 데이터가 겹치는 부분이 넓다.
# Setosa 품종의 경우 Petal의 넓이와 폭의 데이터 편차가 좁다.
# 이상치에 해당하는 데이터가 일부 있다.
# 이상치 = 보통 데이터들이 존재하는 범위 예외의 값


point <- as.numeric(iris$Species) # point 모양 Species 3종류의 값이 1,2,3 으로 들어간다.
color <- c("red","green","blue") #setosa ,virgin, 
pairs(iris[,-5], # 모든 행 5열만 빼고 1열 2열 3열 4열 전체 행 150개의 데이터
      # 5열을 빼고 4열만 가지고 서로서로 짝을 지어서 그래프 그린다.
      pch=c(point), # pch는 그래프 그릴때 도형의 형태를 정의
      # c컬럼함수에서 point는 iris에 있는 Species종을 가져와 numeric으로 
      #수치화하여 수치의 형태로 넣어짐 , point 는 1,2,3
      # pch에서 1이면 동그라미, 2이면 세모, 3이면 더하기
      

      col=color[iris[,5]]
      # iris 데이터의 5열에 해당하는 값 종에 해당하는 3개의 종을 color로 자동으로 매칭
)
# pairs 그리기 시험문제에 나온다.

# <해석>  
# 4개의변수에서 각 그룹간 데이터의 크기는 차이가 존재한다.
# Sepal.Length와 Petal.Length 그리고 petal.length와 petal.width는 
# 강한 양의 상관관계를 보인다.
cor(iris$Sepal.Length, iris$Petal.Length)
cor(iris$Petal.Width , iris$Petal.Length)
