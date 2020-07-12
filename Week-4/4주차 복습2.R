d <- c(1,2,3,4,5,6,7,8,9)
d>=5
d[d>5]
sum(d>5) # 5보다 큰 값의 개수를 출력
sum(d[d>5])
d==5
condi <- d>5
d[condi]


# 연습 1
v1 <- 51:90
v1
v1[v1<60]
sum(v1<70)
v1[(60 < v1) & (v1<73)]
v1[(v1 %% 7==3)]
sum(v1[v1%%2==0])
v1[v1%%2==1 | v1 > 80]
v1[v1%%3==0 & v1%%5==0]


# matrix
z <- matrix(1:20,nrow=4,ncol=5)
z

x <- 1:4
y <- 5:8
m1 <- cbind(x,y)
m1
m2 <- rbind(x,y)
m2

# 행과 열에 이름 붙이기
rownames(z)
colnames(z)
rownames(z) <- c("row1","row2","row3","row4")
z
colnames(z) <- c("col1","col2","col3","col4","col5")
z


z[,"col4"]
z["row1",]


m <- c(10,40,60,20)
f <- c(21,60,70,30)
score <- cbind(m,f)
score
colnames(score) <- c("male","female")
score
score[3,2]

# Data frame
city <- c("Seoul","Tokyo","Washington")
rank <- c(1,3,2)
city.info <- cbind(city,rank)
city.info

iris
dim(iris)

is.data.frame(iris)
iris[,"Species"] # 결과가 vector
iris["Species"] # 결과가 data frame
iris$Species

iris[,c(1:2)]
iris[1:10,c(1:2)]
iris[1:50,c(1:3)]

nrow(iris)
ncol(iris)
names(iris)
head(iris)
tail(iris)

str(iris)
unique(iris[,5])
table(iris[,5])


colSums(iris[,-5])
colMeans(iris[,-5])
rowSums(iris[,-5])
rowMeans(iris[,-5])


# subset() 함수 : 조건에 맞는 행(row) 추출
IR.1 <- subset(iris, Species=="setosa")
IR.1


IR.2 <- subset(iris, Sepal.Length > 5.0 & Sepal.Width > 4.0)
IR.2


# 연습 문제 3

state.x77
st <- data.frame(state.x77)
st
colnames(st)
rownames(st)
nrow(st)
ncol(st)
str(st)
rowSums(st)                                    #3-7
rowMeans(st)

colSums(st)                                    #3-8
colMeans(st)

st["Florida",]
subset(st,rownames(st)=="Florida",)
st[,"Income"]
subset(st,,colnames(st)=="Income")

subset(st,rownames(st)=="Texas",colnames(st)=="Area")

subset(st,rownames(st)=="Ohio",c("Population","Income"))

subset(st,Population>5000)

ss1 <- subset(st,Income>4500)
ss1[,c("Population","Income","Area")]
nrow(ss1)

subset(st,(Area>10000 & Frost > 120))

ss2 <- subset(st,Illiteracy>2.0)
ss2
mss2 <- ss2[,"Income"]
mean(mss2)

ss3 <- subset(st,Illiteracy < 2.0)
ss3
mss3 <- ss3[,"Income"]
mean(mss3)
abs(mean(mss3)-mean(mss2))


ss4 <- subset(st,,Life.Exp)
subset(st,Life.Exp == max(ss4))

ss5 <- subset(st,rownames(st)=="Pennsylvania",colnames(st)=='Income')
ss5
subset(st,Income > ss5[1,1])
