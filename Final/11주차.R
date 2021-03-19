require(graphics) # k-means 클러스터링에서 그래프 그리기 위해

x <- rbind(matrix(rnorm(100, sd = 0.3), ncol = 2), # 평균은 랜덤 값으로 만든다.
           matrix(rnorm(100,mean = 1 ,sd = 0.3), # 평균 1 , 표준편차 0.3
                  ncol = 2))

# 두개의 행렬을 만드는데,
# 100개의 표준편차 0.3인 샘플을 생성해라.

# 100개 100개로 컬럼이 묶인다.


colnames(x) <- c("x","y")

cl <- kmeans(x,2) # x라고 하는 샘플로 2개의 클러스터를 만들어내라
cl
cl # show clustering result

plot(x, col = cl$cluster) # plot 그리기
points(cl$centers, col = 1:2, pch=8, cex=2)

cl <- kmeans(x,5,nstart = 25) # 샘플 데이터를 5개의 클러스터로 나눈다. 25개의 센터
plot(x, col=  cl$cluster)
points(cl$centers, col = 1:5, pch=8)

