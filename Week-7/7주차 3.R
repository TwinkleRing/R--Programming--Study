#사각 타일(square tile)
# 파이 차트(pie chart)는 특정 속성의 구성 비율을 시각화
#파이 차트는 각(angle)의 크기로 비율을 나타내는데,
#각에 대한 인간의 인지력은 좋지 않기 때문에 사각타일이 제안됨

# 예제 데이터

mtcars$carb
table(mtcars$carb)
#값이 1인 차종은 7개, 값이 2인 차의 종류는 10개~~~
  
rm(list=ls()) #앞의 작업 결과 clear
#데이터 준비
carb <- mtcars$carb #변수의 데이터 추출
tbl <- table(carb) # 도수 분포 계산
tbl
prop <- round((tbl/sum(tbl))*100, digit=0) # 비율 계산
sum(prop) # 합이 100이 되는지 확인하고
prop[3] <- prop[3] + 1 # 아니면 100 되도록 맞춘다(반올림 했으니까)
m <- length(prop) # m은 6
m
# pie chart
pie(prop, col=2:(m+1), main="carburators", # prop 비율 변수,col 색의 분포를 2부터 7까지 6 종류
    labes=paste(names(tbl), "EA", prop)) # 

# bar chart
barplot(prop, col=2:(m+1),main="carburators",
        ylim=c(0,40))

prop

# 사각타일
p.vec <- rep(1:m, prop)
p.vec
P <- matrix(p.vec ,10, 10) #10행 10열로 carb 1인 경우 22퍼센트 등등 
# prop 값을 p.vec에 담고 매트릭스화로 분포시킨다.
# 1은 22개 2는 31개 3은 1개 4는 31개 ....
P
color <- 2:(m+1)
image(P, col=color, axes=F, main = "proportions")
# 가로, 세로 격자를 그려서 보기 쉽게
abline(h=seq(-0.05,1.05,1.1/10), col = "white", lwd=4)
abline(v=seq(-0.05,1.05,1.1/10), col = "white", lwd=4)


# 모자이크 플롯
# 모자이크 플롯은 2원,3원 교차표의 시각화이다.
# 전체 정사각 도형을 교차표의 행 빈도에 비례하는 직사각 도형으로 나누고 
# 다시 각 도형을 열의 빈도에 해당하는 직사각 도형으로 나눈다.

rm(list=ls())
# matrix 형태로 데이터가 존재하는 경우
head(mtcars)
mosaicplot(~gear+carb, data=mtcars,color =TRUE) # x축 gear, y축 carb
# off는 각 면적막대 사이의 빈칸


mosaicplot(~gear+carb, data = mtcars, color = c("red","blue"))

Titanic
mosaicplot(Titanic, color=TRUE, off=5)

mosaicplot(Titanic, 
           main="Survival on the Titanic",
           color = c("blue","orange"), off=5)


# 나무지도(Tree map)

install.packages("treemap")


dev.off() #우측 하단의 Plots 창에 있는 모든 Plots들을 삭제(clear, delete)하고 싶을 때


library(treemap)

data(GNI2014) # 데이터 불러오기
str(GNI2014) # 데이터 내용보기
treemap(GNI2014,
        index=c("continent","iso3"),
        vSize="population", # 타일의 크기
        vColor="GNI", # 타일의 컬러
        type="value", # 타일 컬러링 방법
        bg.labels="yellow") # 레이블의 배경색

# index=c("continent","iso3") : 개체의 단위를 지정하는 계층적구조를 갖는 경우
# 상위 층을 먼저 넣는다. , 대륙을 먼저 표현하고 그 안에 국가를 넣으라는 의미
# continent와 iso3를 중점적으로 인덱스화 시켜서 그래프 그려보겠다.
#박스들의 사이즈는 population에 따라 결정
#박스의 색은 gni 값을 분석해서 분포도를 최소값부터 최대값까지 다 분석해서 
#최소값과 최대값의 범위를 결정해서 색을 정한다.
#타일의 크기는 인구 수 타일의 색은 국민소득
#전체영역은 대륙별로 대륙에 속한 나라를 하나로 그룹화시켜서 내부에 그려준다.


# 국가 총소득을 인구수로 나누어서 1인당 gni 계산

GNI2014$GNI.total <- # 국가별 국민 총소득을 계산해서 GNI.total 컬럼에 저장
  GNI2014$population*GNI2014$GNI

head(GNI2014) 
# 국가별 국민 총소득을 대륙별로 합계내서 GNI2014.a에 저장
GNI2014.a <- aggregate(GNI2014[,4:6],
                       by=list(GNI2014$continent),sum)

  
#aggregate() 로 데이터 편집하는데.
#GNI와 Population, GNI.total 3개의 열을 대륙별로 더한다.

#대륙을 기준으로 gni2014의 4열부터 6열까지의 데이터를 전부 더해서
#그 내용을 GNI2014.a에 저장한다.

# 대륙별 합계를 대륙 인구수로 나누어 GNI.percap 컬럼에 저장
GNI2014.a
GNI2014.a$GNI.percap <- GNI2014.a$GNI.total/GNI2014.a$population
GNI2014.a
treemap(GNI2014.a, 
        index=c("Group.1"),
        vSize="population", # 박스의 크기는 인구수
        vColor="GNI.percap", # 대륙별 1인당 국민소득이 색
        type="value", # 색을 나타내는 해당 수치값들을 값으로 환산하여 색으로표현
        bg.labels="yellow")

