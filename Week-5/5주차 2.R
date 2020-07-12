getwd()

ds <- read.csv("gdp.csv",header=F)
m.gdp <- as.matrix(ds)
v.gdp <- as.vector(t(m.gdp))
GDP <- ts(data=v.gdp,
          start=c(1970,1), # 첫 데이터는 1970년 1분기
          frequency = 4) # 1년당 4개의 데이터 존재
GDP

# t() : 배열의 행과 열을 바꾸는 함수
# ts() : matrix로 부터 시계열 데이터를 생성하는 함수 


class(GDP)

plot(GDP, main="gdp plot")

