# 버블 차트

#2개의 변수가 차지하고 있는 정량적인 양(frequency)에 따라 버블의 크기 달라짐
install.packages("MASS")
library(MASS)
head(UScrime)

radius <- sqrt(UScrime$Pop) # 원의 반지름(값이 커서 줄임)
symbols(UScrime$U2, UScrime$y, # x,y축
        circles=radius, # 원의 반지름값
        inches=0.4,  # 원의 크기 조절값, 전체적인 원의 크기(총체적)
        fg="white", # 원의 테두리색
        bg="lightgray", # 원의 바탕색
        lwd=1.5, # 원의 테두리선 두께
        xlab = "unemployment 35-39 males",
        ylab = "UScrime Data")
text(UScrime$U2, UScrime$y, # 텍스트가 출력될 x,y 좌표
     1:nrow(UScrime), # 출력될 text,  1부터 마지막 행까지
     cex=0.8, # 폰트 크기
     col="brown") # 폰트 컬러



# 다중 상자그림(Boxplot)
getwd()
ds <- read.csv("국회의원_선거구_유권자수.csv", header = T)
head(ds)
summary(ds$선거인.수)

# 선거구별 선거인수 (전국)
boxplot(ds$선거인.수,
        col="yellow",
        ylim=c(0,250000),
        xlab="전국",
        ylab="선거인수")

# 시도번호로 그룹핑한후 그룹열로 선거인.수의 중간값을 계산
# 5열 전체 선거인수를 1번째 열 시도에 따라서 중간값을 구하라.
# 서울의 중간값, 대구의 중간값 ..........
cnt <- aggregate(ds[,5],by=list(ds$시도),median)
# 선거인.수의 중간값이 큰 순서에서 작은 순서로 순위 계산
odr <- rank(-cnt$x) # - 이므로 내림차순, 미디언 값이 저장된 열인 x

cnt
odr # 각 행 번호가 가지는 랭킹 번호

# 시도를 기준으로 그룹핑하여 다중 상자그림을 그린다.
boxplot(선거인.수~시도, data=ds,
           col=heat.colors(16)[odr], # 상자의 색을 지정
           ylim=c(0,250000),
           ylab="선거인수",
           main="18대 국회의원 선거구의 시도별 선거인수 분포")

# 평균선거인수가 많은수록 붉은색, 적을수록 연한 노랑색
