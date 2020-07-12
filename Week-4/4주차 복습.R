# 논리 값 벡터 다루기
# 논리연산자 : < , >, <= , ==, !=, | , &

d <- c(1,2,3,4,5,6,7,8,9)
d>=5
d[d>5] # 6,7,8,9
sum(d>5) # 5보다 큰 값의 개수를 출력
sum(d[d>5]) # 5보다 큰 값의 합계를 출력

d == 5
condi <- d > 8
d[condi]

v1 <- 51:90
v1[v1<60]
sum(v1 < 70)
sum(v1[v1>65])
v1[(v1 < 65) | (v1 > 80)]
v1[(v1%%7)==3]
sum(v1[v1%%2==0]) # 짝수들의 합계
v1[(v1%%5==0)&(v1%%3==0)] # 3과 5의 공배수



# 2차원 데이터 다루기
# 2차원 데이터를 저장하기 위해서는 R 에서는 matrix 또는 data frame을 사용
# matrix : 모든 저장된 데이터의 데이터 타입이 동일
# data.frame : 서로 다른 유형의 데이터 타입을 가진 값들을 저장

z <- matrix(1:20, nrow=4,ncol=5) # nrow는 행의 수, ncol은 열의 수
z

x <- 1:4
y <- 5:8
m1 <- cbind(x,y)
m1

m2 <- rbind(x,y)
m2

m3 <- rbind(m2,x)
m3

m4 <- cbind(z,x)
m4


# matrix 안에서의 위치 지정
z[2,3] # z의 2행 3열에 있는 값

rownames(z)
colnames(z)
rownames(z) <- c("row1","row2","row3","row4")
colnames(z) <- c("col1","col2","col3","col4","col5")
z

# 행, 열 이름으로 데이터 접근하기

z[,"col3"]
z["row1",]

m <- c(10,40,60,20)
f <- c(21,60,70,30)
score <- cbind(m,f)
score

names(score)

colnames(score) <- c("male","female")
score
score[2,] # 2행에 있는 모든 값을 보여라
score[,"female"]
score[3,2]



# Data frame 만들기
city <- c("Seoul","Tokyo","Washington")
rank <- c(1,3,2)
city.info <- data.frame(city,rank)
city.info # 컬럼별로 데이터 타입이 동일해야한다.

iris
is.data.frame(iris)
iris[,"Species"]
iris["Species"] # 결과가 nx1 data frame
iris$Species # 결과가 vector


iris[,c(1:2)] # 앞의 2개 컬럼 데이터 보기
iris[,c(1,3,5)]
iris[,c("Sepal.Length","Species")]
iris[1:50,]
iris[1:50,c(1:3)]


dim(iris) # 행과 열의 수 보기
nrow(iris) # 행의 수 보기
ncol(iris) # 열의 수 보기
names(iris) # 컬럼 이름 보기
head(iris) # 데이터셋의 앞부분 일부 보기
tail(iris) # 데이터셋의 뒷부분 일부 보기

str(iris) # 데이터셋 요약 보기
unique(iris[,5]) # 종의 종류보기(중복제거)
table(iris[,"Species"]) # 종의 종류별 instance count


colSums(iris[,-5]) # 5열(Species)을 제외한 모든 열별 합계
colMeans(iris[,-5]) # 열별 평균
rowSums(iris[,-5]) # 행별 합계
rowMeans(iris[,-5]) # 행별 평균


# subset() 함수 : 조건에 맞는 행(row) 추출
IR.1 <- subset(iris, Species=="setosa")
IR.1
IR.2 <- subset(iris,Sepal.Length<5.0 & Sepal.Width < 4.0)
IR.2


# 연습3

state.x77 # 미국 50개 주에 대한 통계데이터
st <- data.frame(state.x77)
is.data.frame(st)
dim(state.x77) # 50행 8열 데이터
rownames(state.x77) # 행은 미국 50개 주
colnames(state.x77) # 각 주에 대한 정보들
str(st)
colSums(st) # st의 열별 합계
colMeans(st) # st의 열별 평균
rowSums(st) # st의 행별 합계
rowMeans(st) # st의 행별 평균

# Florida 주의 모든 정보를 보이시오.
st["Florida",]
subset(st,rownames(st)=="Florida") 
# 50개 주의 Income 정보
st[,"Income"]


st["Texas","Area"]
subset(st,rownames(st)=="Texas",colnames(st)=="Area") 

# Ohio주의 인구와 수입
st["Ohio",c("Population","Income")] 

# 인구가 5000 이상인 주의 데이터만 보이시오
subset(st,Population > 5000)

# 수입이 4500 이상인 주의 인구,수입,면적을 보이시오
ss1 <- subset(st,Income > 4500)
ss1[,c("Population","Income","Area")] 
nrow(ss1)
# 전체면적(Area)이 100000 이상이고 결빙일수가 120일 이상인 주
subset(st,(Area >= 100000) & (Frost >= 120)

# 문맹률이 2.0 이상인 주의 평균 수입
ss2 <- subset(st,Illiteracy >= 2.0)
ss2
mss2 <- mean(ss2[,"Income"])
mss2

# 문맹률이 2.0 미만인 주와 2.0 이상인 주의 평균수입의 차이를 보이시오
ss3 <- subset(st,Illiteracy < 2.0)
ss3
mss3 <- mean(ss3[,"Income"])
mss3

abs(mss3-mss2) # 절대값 abs()

# 기대수명이 가장 높은 주는 어디인가.
ss4 <- subset(st,,colnames(st)=="Life.Exp")
ss4

subset(st,Life.Exp==max(ss4)) 

# 펜실베이나보다 수입이 높은 주들을 보이시오
ss5 <- subset(st,rownames(st)=="Pennsylvania",colnames(st)=="Income")
ss5
subset(st,Income>ss5[1,1])
