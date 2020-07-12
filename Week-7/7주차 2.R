# 1. 패키지설치
# R studio 에서 패키지 설치하기
Packages -> Install 클릭
#library() 함수를 통해서 설치된 패키지를 호출한 후 함수 사용
# 2. 이변량 밀도(Bivariate density)
# 등고선을 활용하여 산점도에서 잘 드러나지 않는 부분을 보여준다.
# 실습에 필요한 패키지 = MASS, KernSmooth
# 대상 데이터셋 : MASS 패키지의 geyser, 
# 옐로우스톤 국립공원의 간헐철에서 관측된 대기시간(waiting)과 지속시간(duration)으로 구성
rm(list=ls()) # 앞의 정의된 변수에 할당된 값 모두 삭제
library(MASS)
head(geyser)
class(geyser)
dim(geyser) #299행 2열 데이터
#1열은 기다리는 시간, 2열은 뜨거운 물이 뿜어지는 지속시간
plot(geyser) # 산점도 그리기
plot(geyser,
     xlim=c(30,120),
     ylim=c(0,6.5),
     col="forestgreen",
     pch=20,
     main="geyser")

library(KernSmooth) # 산점도 위에 등고선 그리기
density <- bkde2D(geyser,bandwidth = c(5,0.8))
par(new=T) # 뒤의 그래프(contour)를 앞의 그래프(plot)위에 겹쳐 그리도록 한다.
contour(density$x1,density$x2,density$fhat, #contour() : 등고선을 그리는 함수
        xlim=c(30,120),ylim=c(0,6.5),
        col=heat.colors(7)[7:1], # 등고선 색깔은 heat.colors()는 빨간색, 7단계
        nlevels=7,lwd=2) # line width 등고선의 너비
# x1축은 대기시간, x2축의 지속시간 fhat은 분포이고 개수를 빈도수 형태로 밀도 계산
# bkde2D() : 데이터의 분포 밀도를 추정하는 함수
# bandwidth=c(5,0.5) : 등고선의 모양 조절 c(x축방향,y축방향). 데이터에 따라
# 특성이 잘 드러나도록 값을 조절하여 사용한다.
# y축방향은 간 구간 범위보다 작게, x축방향도 40~60~80~ 등 보다 작게
# 3. 이변량 히스토그램 
# 이변량 히스토그램은 이변량 밀도와 유사하나 3차원 구조로 분포를 보여준다.
# 필요한 패키지 : MASS, lattice, latticeExtra
rm(list=ls())
library(lattice)
library(latticeExtra)
library(MASS)

par(mfrow=c(1,2)) # 매트릭스 포맷을 1행 2열의 형태로 윈도우를 나눈다.(방을 나눈다.)
hist(geyser$waiting, nclass=20,main="geyser",
     xlab="waiting",xlim=c(40,120),ylim=c(0,80))
hist(geyser$duration, nclass=16, main="geyser",
     xlab="duration",xlim=c(0,8),ylim=c(0,80))

# 이변량 히스토그램
rm(list=ls()) # 앞의 작업 결과 clear
# 이변ㅇ량 히스토그램 데이터 준비
x.waiting <- cut(geyser$waiting,10) #geyser$waiting 의 데이터를 10개의 구간으로 나눈다.
levels(x.waiting) <- paste("w",1:10) # 10개의 구간에 이름은 w1,w2,w3,...,w10처럼 붙인다.
y.duration <- cut(geyser$duration,8) # 
levels(y.duration) <- paste("d",1:8)
geyser.freq <- table(x.waiting, y.duration) # w.waiting와 y.duration의 구간 데이터를 가지고 교차테이블을 만든다.
# 구간이 10개와 8개의 구간으로 나뉘어 그 사이사이에 존재하는 빈도수를 x축 y축으로 분포를 잡아준다.
geyser.freq # 여기에 있는 값을 가지고 탑을 쌓는다. 값의 크기가 탑의 높이로 표현됨


# 이변량 히스토그램 그리기
cloud(geyser.freq,
      panel.3d.cloud = panel.3dbars,
      main="geyser",
      xlab="waiting", ylab="duration", zlab="freq",
      zlim = c(0,max(geyser.freq)*1.5), # 0부터 geyser.freq의 최대 빈도수 1.5배 만큼의 칸을 높이로
      scales = list(arrows = FALSE, just = "rigth"), # z축 화살표 옵션 제거,오른쪽 정렬
      col.facet = level.colors(geyser.freq,
        at = do.breaks(range(geyser.freq), 24),
        col.regions = terrain.colors, colors = TRUE),
      screen = list(z = 30, x = -30)) # 그래프 보는 각도
      

# zlim = c(0,max(geyser.freq)*1.5) : z축 천정의 높이 지정
# 이 값을 지정 안하면 제일 긴 막대가 천정에 닿는다.


# 4 사각 타일
# 5. 모자이크 플롯
# 6. 나무지도

