# 시계열 데이터 시각화

# 년도/분기별 GNP 데이터 csv로 저장시 년도,분기 값을 제외된다.

ds <- read.csv("gdp.csv",header=F)

m.gdp <- as.matrix(ds)
v.gdp <- as.vector(t(m.gdp)) # t() : 배열의 행과 열을 바꾸는 함수

GDP <- ts(data=v.gdp,
          start=c(1970,1), # 첫 데이터는 1970년 1분기
          frequency=4) # 1년당 4개의 데이터 존재
 
GDP
class(GDP) # 시계열 자료

plot(GDP, main="GDP plot")
