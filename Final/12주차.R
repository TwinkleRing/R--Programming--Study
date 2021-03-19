# K-NN algorithm
# 빅데이터로 부터 인간에게 이로운 정보를 뽑아내고나서
# 인공지능 시스템 상에서 이를 인간이 활용할 수 있도록 분석해주길 바란다.

# 머신러닝 내의 전통적인 K-means를 다뤘고
# K - NN 알고리즘을 배워보겠다.

# 최근접 이웃에 있는 K 개수의 샘플을 찾아서 
# 그 샘플이 어디에 속해있는지 따져봐서
# 그 속한 샘플의 그룹에다가 현재 타켓에 올라와있는 샘플을 귀속시킨다.

require("class")

# prepare train/test data
tr.idx <- c(1:25,51:75,101:125)
tr.idx
ds.tr <- iris[tr.idx,1:4]
ds.ts <- iris[-tr.idx,1:4]
ds.ts
cl.tr <- factor(iris[tr.idx, 5])
cl.ts <- factor(iris[-tr.idx,5])

pred <- knn(ds.tr, ds.ts, cl.tr,cl.ts, k = 3 , prob= TRUE)
pred

acc = mean(pred==cl.ts) # 예측 정확도
acc


table(pred,cl.ts)
