##### 빅데이터처리 중간고사 답안 - 32140878 - 김영훈  ##########

#### 1번 답안 ############

lynx

#평균값
mean(lynx)
#중앙값
median(lynx)
#절사평균값(절사범위 10%)
mean(lynx, trim=0.1)
#표준편차
sd(lynx)
#boxplot
boxplot(lynx)


#### 2번 답안 ############
# state.x77 데이터셋에서 Illiteracy와 HS Grad의 
#변량 데이터에 대하여 이변량 밀도 그래 프를 산점도와 등고선을 포함하여 그리고,
# 또한 3차원 이변량 히스토그램을 그린 후  여기서 관찰되는 내용을 R코드 내에 주석으로 달고 설명하시오.


rm(list=ls())
Illiteracy <- state.x77[,"Illiteracy"]
HSGrad <- state.x77[,"HS Grad"]

st <- data.frame(HSGrad,Illiteracy)
st
max(Illiteracy); min(Illiteracy) # 0 40
max(HSGrad); min(HSGrad) # 80 50

# 산점도 그리기
plot(st,
     xlim=c(30,80),
     ylim=c(0,3.0),
     col="forestgreen",
     pch=20,
     main="st")

# 산점도 위에 등고선 그리기
library(KernSmooth)
density <- bkde2D(st,bandwidth=c(5,0.5))
par(new=T)
contour(density$x1, density$x2, density$fhat,
        xlim=c(30,80), ylim=c(0,3.0), 
        col=heat.colors(7)[7:1],
        nlevels=7,lwd=2)

# 3차원 이변량 히스토그램 그리기

# 필요한 패키지 불러오기
library(lattice)
library(latticeExtra)

# 데이터 준비
head(st)
x.HSGrad <- cut(state.x77[,"HS Grad"],10)
levels(x.HSGrad) <- paste("HSGrad", 1:10)
y.illiteracy <- cut(state.x77[,"Illiteracy"],8)
levels(y.illiteracy) <- paste("illiteracy",1:8)
state <- table(x.HSGrad,y.illiteracy)
state

cloud(state,
      panel.3d.cloud = panel.3dbars,
      main= "HS Grad$Illiteracy",
      xlab= "HSGrade", ylab="Illiteracy", zlab = "freq",
      zlim= c(0,max(state)*1.5),
      scales=list(arrows=FALSE , just = "right"),
      col.facet = level.colors(state,
                  at = do.breaks(range(state), 24),
                  col.regions = terrain.colors, colors = TRUE),
      screen = list(z = 30, x = -60))

# 관찰된 내용 : 1.문맹률이 낮은 주 일수록 고등학교를 졸업한 사람의 비율이 높았다.



#### 3번 답안 ############
# mtcars 데이터셋의 cyl, gear, carb 변량 데이터에 대하여 
#사각타일그래프, 파이그래프, 막대그래프를 각각 작성하시오

# 데이터 준비
rm(list=ls())
cyl <- mtcars$cyl
gear <- mtcars$gear
carb <- mtcars$carb
tbl1 <- table(cyl);  tbl2 <- table(gear);  tbl3 <- table(carb)

# prop1(cylinder 데이터)
prop1 <- round((tbl1/sum(tbl1))*100, digit=0) 
sum(prop1)
m1 <- length(prop1) # m1은 3
# prop2(gear 데이터)
prop2 <- round((tbl2/sum(tbl2))*100, digit=0)
sum(prop2)  # prop2(gear 데이터) 가 101 이므로 1을 빼준다.
prop2[3] <- prop2[3] - 1
sum(prop2) # 100으로 맞춰줍니다.
m2 <- length(prop2) # m2은 3
m2
# prop3(carb 데이터)
prop3 <- round((tbl3/sum(tbl3))*100, digit=0)
sum(prop3)
prop3[3] <- prop3[3] + 1 # prop3(carb 데이터)를 100으로 맞춰줍니다.
sum(prop3) 
m3 <- length(prop3) # m3은 6
m3

par(mfrow=c(3,3)) # 윈도우 3x3 , 총 9개 화면으로 분할

# cylinder 데이터
# pie chart
pie(prop1, col=2:(m1+1), main="cylinder",
    labels=paste(names(tbl1), "EA",prop1))
# bar chart
barplot(prop1, col= 2:(m1+1), main="cylinder",
        ylim= c(0,40))
# square tiles
p1.vec <- rep(1:m1, prop1)
P1 <- matrix(p1.vec, 10, 10)
color <- 2:(m1+1)
image(P1, col=color, axes=F, main="proportions")

abline(h=seq(-0.05,1.05,1.1/10),col="white",lwd=4)
abline(v=seq(-0.05,1.05,1.1/10),col="white",lwd=4)

# gear 데이터

# pie chart
pie(prop2, col=2:(m2+1), main="gear",
    labels=paste(names(tbl2), "EA",prop2))
# bar chart
barplot(prop2, col= 2:(m2+1), main="gear",
        ylim= c(0,40))
# square tiles
p2.vec <- rep(1:m2, prop2)
P2 <- matrix(p2.vec, 10, 10)
color <- 2:(m2+1)
image(P2, col=color, axes=F, main="proportions")

abline(h=seq(-0.05,1.05,1.1/10),col="white",lwd=4)
abline(v=seq(-0.05,1.05,1.1/10),col="white",lwd=4)

# carb 데이터

# pie chart
pie(prop3, col=2:(m3+1), main="carb",
    labels=paste(names(tbl3), "EA",prop3))
# bar chart
barplot(prop3, col= 2:(m3+1), main="carb",
        ylim= c(0,40))
# square tiles
p3.vec <- rep(1:m3, prop3)
P3 <- matrix(p3.vec, 10, 10)
color <- 2:(m3+1)
image(P3, col=color, axes=F, main="proportions")

abline(h=seq(-0.05,1.05,1.1/10),col="white",lwd=4)
abline(v=seq(-0.05,1.05,1.1/10),col="white",lwd=4)



#### 4번 답안 ############
# 모자이크 플롯
rm(list=ls())
par(mfrow=c(1,2))
Black <- c(5,3,2,16,2)
Blue <- c(17,7,19,47,8)
Red <- c(2,8,25,27,11)
Yellow <- c(11,5,35,13,9)
Green <- c(3,36,12,23,32)

DOG <- cbind(Black,Blue,Red,Yellow,Green)
rownames(DOG) <- c("Black","Brown","Bronze","Silver","Gold")
DOG

mosaicplot(DOG,
           main="DOG BODY & EYE",
           xlab = "Body Color",
           ylab = "Eye color",
           color = c("gold","black"),
           off= 4)

Black <- c(23,36,19,3,14)
Blue <- c(25,37,41,17,5)
Red <- c(10,16,23,3,4)
Yellow <- c(8,9,4,2,14)
Green <- c(3,12,6,7,1)

CAT <- cbind(Black,Blue,Red,Yellow,Green)
rownames(CAT) <- c("Black","Brown","Bronze","Silver","Gold")

CAT

mosaicplot(CAT,
           data= CAT,
           main="CAT BODY & EYE",
           xlab = "Body Color",
           ylab = "Eye color",
           color = c("gold","black"),
           off= 4)

# 관찰되는 내용 : 


#### 5번 답안 ############

# 데이터 준비
getwd()
mydata <- read.csv("행정구역_시군구_별__성별_인구수.csv",header = TRUE)
library(treemap)
help(treemap)
str(mydata) 
head(mydata)



