library(nnet)


data <- read.csv("kospi.csv")

names(data)[1:2] = c("ymd","current") # 1열과 2열에 이름을 붙여준다.
head(data)
data$current <- gsub(",","", data$current) # current의 콤마 제거

is.character(data$ymd)
df <- data.frame(ymd=as.factor(data$ymd),  # factor은 범주형 자료
                 current=as.numeric(data$current))

plot(df$ymd, df$current, xlab="일자", ylab="현재지수",
     type="o")

is.numeric(df$current)
head(df)
is.factor(df$ymd)



# 3단계 : 테스트(1) : 학습 데이터 생성
# Training/Test dataset 생성, 테스트 데이터로 주가 예측
# 에러 계산 : 실제 주가지수와 예측된 주가지수의 차이

df <- df[order(df$ymd),] # sort data , 날짜 순으로 sort

# create traing data
train_learning <- NULL # train(학습) 과정에서 문제를 주고 답을 줘야지 학습을 한다.
train_result <- NULL # train(학습) 과정에서의 해답
for (i in 1:108) {
  train_learning <- rbind(train_learning,
                          df$current[i:(i+9)]) # 주가지수값 데이터 묶어서 i=1이면 1부터 10까지
  train_result <- rbind(train_result,
                        df$current[(i+10):(i+14)]) # i=1이면 11부터 15까지 
  # 시계열 데이터 10일치 데이터를 가지고 학습해서 5일치 데이터를 예측하도록. 
  # 과거 10일치가 문제로 주어지고, 미래 5일치를 답으로 취할수 있도록 학습시킨다.
}

dim(train_learning); dim(train_result)
# 과거 10일치를 학습해서 미래 5일치 예측하고
# for문이 돌면서 i값에 따라 계속겹치면서 10일치로 향후 5일치를 예측하는 모델
# 문제와 답을 동시에 주면서 뉴럴네트워크 시스템에 학습을 할 수 있도록 자료를 제공


# 3단계 : 테스트(2) : 테스트 데이터 생성

# create test data
test_learning <- NULL
test_result <- NULL
for (i in 51:100) {
  test_learning <- rbind(test_learning,
                         df$current[i:(i+9)])
  test_result <- rbind(test_result,
                       df$current[(i+10):(i+14)])
}
# 학습 과정에서 문제가 필요하고 답이 필요하다. 그래야지 전체적인 트레이닝 과정이 완성된다.
# 트레이닝 과정에 완성되면 어떤 문제는 어떻게 풀고 어떤 또 다른 문제는 어떻게 푼다는 모델이 만들어진다.


# training & create a model
HIDDEN.NODES = 20
ITERATION = 500

model <- nnet(train_learning, train_result,
              size=HIDDEN.NODES,
              linout=TRUE, rang=0.1, decay=5e-4,
              skip=TRUE, maxit = ITERATION)

# 주가예측 테스트 실시

# test using model
predicted <- predict(model, test_learning,
                     type="raw")

predicted



err <- abs(test_result - predicted)
MAPE <- mean(err/test_result)*100

mean(err) # 실제주가지수와 예측 주가지수의 차이 평균
MAPE # 실제주가지수에서 에러가 차지하는 비율
# 별로 좋은 모델은 아니다.
 
