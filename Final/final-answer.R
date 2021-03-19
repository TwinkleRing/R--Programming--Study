##### 빅데이터처리 기말고사 답안 - 학번 32140878 - 김영훈 #####
library(ggplot2)
####### 1번 답안 ############

# 1. 법륜스님.txt
library(multilinguer)
library(wordcloud) # 워드클라우드 작성
library(RColorBrewer) # 단어의 색을 처리
library('rJava')
library(KoNLP) # 한국어 처리
useSejongDic() # 세종 한글사전 로딩
pal2 <- brewer.pal(8,"Dark2") # 팔레트 생성
text <- readLines(file.choose()) # 파일 읽기
noun <- sapply(text, extrackNoun, USE.NAMES = F)
# USE.NAMES= T로 하면 단어 결과 위에 본문의 각 행이 포함됩니다.
noun

noun2 <- unlist(noun)
noun2
wordcount <- table(noun2) # 단어 빈도수 계산

sort(wordcount, decreasing=T)[1:10] # 빈도수 제일 많은 것부터 10개를 정렬하여 나열
wordcloud(names(wordcount), 
          freq=wordcount,
          scale=c(6,0.7),
          min.freq=3,
          random.order=F,
          rot.per=.1,
          colors=pal2)

# 무의미한 단어 제거
noun2 <- noun2[nchar(noun2)>1]
noun2 <- gsub("국민","",noun2)
noun2 <- gsub("여러분","",noun2)

wordcount <- table(noun2)
wordcloud(names(wordcount),
          freq=wordcount,
          scale=c(6,0.7),
          min.freq=2,
          random.order = F,
          rot.per=.1,
          colors=pal2)
# 법륜스님은 우리와 사회, 세계와 대한민국 등의 단어를 많이 사용하셨다. 


# 2. pope.txt
library('tm')
# 텍스트 파일 가져오기
data <- readLines(file.choose())
head(data)
# 말뭉치 생성

corp <- Corpus(VectorSource(data))

# 여러 개의 공백을 하나의 공백으로 압축
corp <- tm_map(corp, stripWhitespace)

# 숫자 제거
corp <- tm_map(corp, removeNumbers)

# 특수문자 제거
corp <- tm_map(corp, removePunctuation)

# 대문자를 소문자 변환
corp <- tm_map(corp, tolower)

sword <- c(stopwords('en'),"will","can","and","but","not")
corp <- tm_map(corp,removeWords,sword)

# 워드 클라우드 생성 #

# 팔레트 생성
pal2 <- brewer.pal(8,"Dark2")

# 워드 클라우드 생성

wordcloud(corp,
          scale=c(3,0.5),
          min.freq=2,
          random.order=F,
          random.color = F,
          rot.per = .1,
          colors=pal2
)

# pope.txt에서는 children과 jesus, see, may, world등의 단어가 가장 많이 쓰였다.

##### 2번 답안 ############
install.packages("treemap")
library(treemap)

cw <- data.frame(ChickWeight) # 병아리 데이터 무게,나이,번호,모이종류
tail(cw)
treemap(cw,
        index=c("Diet","Chick"),
        vSize="weight",
        vColor = "weight",
        type="value",
        bg.labels="yellow")




#### 3번 답안 ############
# 4개의 항목을 한 화면에 area chart로 나타낸다.

head(airquality)
air <- data.frame(airquality)
head(air)
grid.arrange(ncol=2,nrow=2) # 윈도우 2x2 , 총 4개 화면으로 분할
air$Month <- as.factor(air$Month)

ggplot(air,
       aes(x=Day,y=Ozone, fill=Month,group=Month)) + 
  geom_area()
ggplot(air,
       aes(x=Day,y=Solar.R, fill=Month,group=Month)) + 
  geom_area()
ggplot(air,
       aes(x=Day,y=Wind, fill=Month,group=Month)) + 
  geom_area()
ggplot(air,
       aes(x=Day,y=Temp, fill=Month,group=Month)) + 
  geom_area()

#### 4번 답안 ############
# bubble chart
library(MASS)
head(USArrests)
arr <- data.frame(USArrests)
radius <- sqrt(arr$UrbanPop)
symbols(arr$Murder,arr$Assault,
        circles=radius,
        inches=0.4,
        fg="white",
        bg="yellow",
        lwd=1.5,
        xlab="US Murder",
        ylab="US Assault",
        main="USArrests Data")
text(arr$Murder,arr$Assault,
     1:nrow(USArrests),
     cex=0.8,
     col="black")



#### 5번 답안 ############

# K-means clustering

require(graphics) # k-means 클러스터링에서 그래프 그리기 위해

x <- rbind(matrix(rnorm(100,mean=2,sd=0.35), ncol=2),  # 평균은 랜덤 값으로 만든다.
           matrix(rnorm(100,mean=5,sd=0.71), ncol=2),
           matrix(rnorm(100,mean=7,sd=0.82), ncol=2),
           matrix(rnorm(100,mean=11,sd=0.45),ncol=2),
           matrix(rnorm(100,mean=19,sd=0.98), ncol=2)) # 평균 1 , 표준편차 0.3

colnames(x) <- c("x","y")
head(x)
nrow(x)
is.array(x)

cl <- kmeans(x,5) # x라는 샘플로 5개의 클러스터를 만들어내라.
cl

plot(x,col=cl$cluster) # plot 그리기
points(cl$centers, col=1:5, pch=8, cex=2)
cl$centers

cl <- kmeans(x,5,nstart=25)
plot(x,col=cl$cluster)
points(cl$centers,col=1:5,pch=8)




###### 6번 답안 ########

library(nnet)

data <- read.csv("pound.csv")

pound <- data.frame(data[-c(1:8),])
head(pound)
names(pound)[1:2] = c("ymd","current") # 1,2열 이름 
head(pound)

pound$current <- gsub(",","",pound$current) # 콤마 제거
df <- data.frame(ymd=as.factor(pound$ymd),
                 current=as.numeric(pound$current))
head(df)

plot(df$ymd, df$current , xlab="일자", ylab="현재 지수",
     type="o")

# 학습/테스트 데이터 생성

df <- df[order(df$ymd),] # sort date

# create traing data
train_learning <- NULL
train_result <- NULL
for (i in 1:108) {
  train_learning <- rbind(train_learning,
                          df$current[i:(i+9)])
  train_result <- rbind(train_result,
                        df$current[(i+10):(i+12)])
}
# 10일치 데이터를 기준으로 향후 5일의 주가를 예측한다.
dim(train_learning)
dim(train_result)

# create test data
test_learning <- NULL
test_result <- NULL
for (i in 51:100) {
  test_learning <- rbind(test_learning,
                         df$current[i:(i+9)])
  test_result <- rbind(test_result,
                       df$current[(i+10):(i+12)])
  
}

dim(test_learning)
dim(test_result)


#  training & create a model
HIDDEN.NODES = 20
ITERATION = 500

model <- nnet(train_learning, train_result,
              size=HIDDEN.NODES,
              linout = TRUE, rang=0.1, decay=5e-4,
              skip=TRUE, maxit=ITERATION)


# 주가 예측 테스트 실시
# test using model
predicted <- predict(model, test_learning,
                     type="raw")
predicted # 3일치 예측된 주가 데이터 결과


# 예측 에러 계산
err <- abs(test_result- predicted) 
MAPE <- mean(err/test_result)*100

mean(err)
MAPE

# mean(err)은 실제 주가와 예측 주가의 차이의 평균으로 7.474만큼 차이가 나며
# MAPE는 0.50이 나오므로 실체주가에서 에러가 차지하는 비율이 50%나 된다.
# 따라서 정답일 확률은 50%로 예측이 잘 되지 않는 모델이다.
