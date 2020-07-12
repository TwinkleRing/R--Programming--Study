# 6주차 목요일

#상관분석 두 변수 x,y 간의 선형성의 정도를 측정하는 통계량
# Correlation Analysis

# -1 <= r <= 1
# r > 0 : 양의 상관관계
# r < 0 : 음의 상관관계
# 1이나 -1에 가까울수록 상관성이 높다.

beers = c(5,2,9,8,3,7,3,5,3,5)
bal = c(0.1,0.03,0.19,0.12,0.04,0.0095,0.07,0.06,0.02,0.05)
tbl = data.frame(cbind(beers,bal))
tbl;
class(tbl)
plot(bal~beers,data=tbl)
res = lm(bal~beers,data=tbl) #최소자승법으로 회귀선 도출
abline(res) #회귀선 그리기, 
#절대값을 표현할수있는 그래프 함수

cor(beers,bal) #상관성 분석 시행
# 그래프가 양의 관계로 정비례에 가까운 비례 관계이다.



tbl = data.frame(cbind(beers,bal))
# -> data.frame : 데이터를 테이블 형태로 관리
# -> cbind() : 두 벡터를 컬럼(열) 방향으로 합침
# (cf. rbind() : 두 벡터를 행 방향으로 합침)

plot(bal~beers, data = tbl) # 산점도 (beers 이 x축)
# -> 두 벡터 데이터를 가지고 산점도를 그린다.
# -> plot(tbl), plot(tbl[,1],tbl[,2]) 와 동일한 결과

res = lm(bal~beers, data = tbl)
# -> 산점도를 가장 잘 표현하는 선형 모델(회귀식)을 구함

abline(res) # 선 그리기
# 구한 선형모델을 가지고 산점도 위에 선을 그린다.

cor(beers,bal) # 상관성 분석 시행
# 두 벡터자료로부터 상관계수를 계산한다.



