require(nnet)
data(iris)

train = iris[,-5]  # data
test = train
targets = class.ind(iris[,5])  # class , 실제 150개 데이터의 정답
# 출력으로 나오게될 데이터 , 해답(목적)  ==> 5열 값 (종)


model = nnet(train, targets, size = 8,  
             rang = 0.1, decay = 5e-4, maxit = 200)

# test with train data
pred <- predict(model,train) # 예측한 결과
head(pred)


#calculate accuracy
predClass = max.col(pred) # 예측한 결과

testClass = max.col(targets) # 실제 답인 결과
acc = mean(predClass == testClass)

# check accuracy
acc
table(predClass,testClass)
