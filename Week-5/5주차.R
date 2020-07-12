mydata = c(50,60,100,75,200)
mydata.big = c(mydata,50000)
mean(mydata)
mean(mydata.big)

median(mydata)
median(mydata.big)

mean(mydata,trim=0.2)

quantile(mydata)

quantile(mydata,(0:10)/10)

summary(mydata)
fivenum(mydata)

# 도수분포표
ans=c("Y","Y","N","Y","Y")
table(ans)

#최대값 - 최소값
diff(range(mydata))
#분산
var(mydata)
#표준편차
sd(mydata)

# box plot

# Bar blot
head(mtcars)
carb <- mtcars[,"carb"]
table(carb)
barplot(table(carb),
        main = "Barplot of Carburetors",
        xlab="#of carburetors",
        ylab="frequency")

table(mtcars$carb)

barplot(table(carb),
        main = "Barplot of Carburetors",
        xlab="#of carburetors",
        ylab="frequency",
        col="red")

par(mfrow=c(1,3))
barplot(table(mtcars$carb),
        main="Barplot of Carburetors",
        xlab="#of carburetors",
        ylab="frequency",
        col="blue")
barplot(table(mtcars$cyl),
        main="Barplot of Cylender",
        xlab="#of cylender",
        ylab="frequency",
        col="red")
barplot(table(mtcars$gear),
        main="Barplot of Gear",
        xlab="#of gears",
        ylab="frequency",
        col="green")

# histogram  정수형,문자형은 도수분포표 
# 실수형 자료는 히스토그램을 사용한다.

st.income <- state.x77[,"Income"]
hist(st.income,
     main="Histogram for Income",
     xlab = "income",
     ylab = "frequency",
     border = "blue",
     col="Green",
     las=2,
     breaks = 5)

head(state.x77)
st.income <- state.x77[,"Income"]
boxplot(st.income, ylab="Income value")

        

boxplot(Petal.Width~Species,data=iris,ylab="Petal.Width")

#paste함수 : 여러 문자열으 연결하여 하나로 묶을때 사용
paste("Good","Morning","Tom", sep=" ")
paste("Good","Morning","Tom", sep="/")
paste(1:10,"is good" , sep=" ")


# 시계열 데이터의 시각화
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
