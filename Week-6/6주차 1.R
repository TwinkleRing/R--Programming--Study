wt <- mtcars$wt
mpg <- mtcars$mpg
plot(wt, mpg,
     main = "Car Weight-mpg", # 전체 그래프의 제목
     xlab = "Car Weight ", # x축의 제목
     ylab = "Miles Per Gallon", # y축의 제목
     col = "red", #point 의 컬러
     pch = 8) # point의 종류
# mtcars 데이터셋에서 자동차 중량(wt)와 
# 연비(mpg)의 상관관계를 산점도로 확인
# => 중량이 큰 차일 수록 연비가 떨어진다.

# 산점도
# plot(x축 데이터, y축 데이터, 옵션)
# main="메인제목"
# sub="서브제목"
# ann=F x,y축 제목 지정하지 않음
# tmag=2 x,y축을 표시하지 않음
# axes=F x,y축을 표시하지 않음
# axis x,y축을 사용자의 지정값으로 표시

# pairs() 여러 변수들 사이의 상관관계를 한번에 확인
vars <- c("mpg","disp","drat","wt")
target <- mtcars[,vars] # matrix 데이터
pairs(target,main="Multi plots") #각각의 짝 끼리 plot 그려서 보여라


# 중량(wt)이 커질수록 배기량(disp)도 높아진다.
# 마일리지(mpg)가 높을수록(경차 일수록) 배기량(disp)은 작다



#iris 데이터셋에서 species 정보에 따른 petal.Length, 
# petal.Width의 분포


iris.2 <- iris[,3:4] #species의 열 데이터만 뽑아낸다.
point <- as.numeric(iris$Species) #point 모양
color <- c("red","green","blue")  #point 컬러
plot(iris.2,
     main="Iris plot",
     pch=c(point), # 자동으로 1,2,3으로 수치정보가 pch에 저장
     col=color[iris[,5]]) # iris데이터 모든행의 5열의 정보
#species가 3종이니 자동으로 색이 붙음
#setosa : 1 , versicolor:2, virginica:3 을 값이 변환된다.

# 선 그래프
plot(cars,
     main="Car plot",
     pch=c(point),
     type="o" # point 타입이 p 이면 점 모양그래프(기본값)
)

# type="o" 점위의 선
# type="h" 값에 해당하는 수직선
# type="s" 계단형


# 선그래프에서 선의 종류 지정
plot(cars,
     main="Car plot",
     pch=c(point),
     type="l", # point 타입이 p 이면 점 모양그래프(기본값)
     lty=1, #선의 종류(line type) 선택
     lwd=1 #선의 굵기 선택
)


# 1871~1970 나일강 범람 데이터
plot(1871:1970, # x data
     as.numeric(Nile), # y data (Nile 데이터 안의 값 수치화)
     main="Nile",
     type="l",
     lty = 1,
     lwd = 1,
     xlab="Year",
     ylab="Amount"
)
Nile                
                
     
     
     
     
     
