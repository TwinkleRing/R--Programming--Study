# ggplot : 시각화 라이브러리
library(ggplot2)
# 산점도
ggplot(data=iris, # ggplot() 함수 시각화할 데이터와 축을 지정한다.
       aes(x=Petal.Length, y = Petal.Width)) +
       # x축 변수와 y축 변수
      geom_point(aes(color=Species, shape=Species), # geom_point()는 산점도
             alpha=0.5, # alpha는 투명
             size=2) +
      ggtitle("IRIS data") +
      theme(plot.title = element_text(size=14,face="bold",color="blue", hjust=0.5)) +
      xlab("꽃잎의 길이") +
      ylab("꽃잎의 폭")

# geom_point() : 산점도
# geom_line() : 선 그래프
# geom_boxplot() : 박스플롯
# geom_histogram() : 히스토그램
# geom_bar() : 막대 그래프
# ggplot은 + 기호로 연결해 구문을 작성한다.

# 막대 그래프 - 가로로 그리기 (coord_flip() 함수 사용)
df = data.frame(table(mtcars$carb))
df
ggplot(df,aes(x=Var1, y =Freq)) +
  geom_bar(stat="identity", width = 0.7,
           fill="steelblue") +
           coord_flip() # coord_flip()은 x축과 y축의 구성을 뒤집어 표현하는 명령, 
                        #가로의 막대로 값을 표현하는 bar 그래프 그린다.


# 그룹별 히스토그램 1
ggplot(iris, aes(x=Petal.Length,
                 fill=Species, color=Species)) +
  geom_histogram(position="stack")



# 그룹별 히스토그램 2
ggplot(iris, aes(x=Petal.Length,
                 fill=Species, color=Species)) +
  geom_histogram(position="dodge")

# 선 그래프
year <- 1937:1960
cnt <- as.vector(airmiles)
df <- data.frame(year,cnt) # 데이터 준비
head(df)

ggplot(data=df, aes(x=year, y = cnt)) +
  geom_line(col="red") +
  geom_point()


# 다중 선 그래프
head(economics)
tmp <- data.frame(economics)
head(tmp)
# 그래프 그릴 두 변수 
pas <- data.frame(ymd=tmp$date, value=tmp$psavert, 
                  grp=rep("psa",nrow(tmp))) 
head(pas)
uem <- data.frame(ymd=tmp$date, value=tmp$uempmed,
                  grp=rep("uem",nrow(tmp)))
head(uem)


df <- rbind(pas,uem)
head(df)
ggplot(data=df, aes(x=ymd, y=value,
                    group=grp, color=grp)) +
  geom_line() +
  geom_point()



# boxplot with data points
ggplot(data=iris,
       aes(x=Species, y = Petal.Length,
           fill=Species)) +
  geom_boxplot() +
  geom_jitter(shape=16,
              position=position_jitter(0.2)) # 점 사이의 거리
  # jitter은 각각의 점의 위치를 범위 내에서 수평 분산
  

# Gauge chart(게이지 차트)
gg.gauge <- function(pos,breaks=c(0,30,70,100)) {
  require(ggplot2)
  get.poly <- function(a,b,r1=0.5,r2=1.0) {
    th.start <- pi*(1-a/100)
    th.end <- pi*(1-b/100)
    th <- seq(th.start,th.end,length=100)
    x <- c(r1*cos(th), rev(r2*cos(th)))
    y <- c(r1*sin(th), rev(r2*sin(th)))
    return(data.frame(x,y))
  }
  ggplot() +
    geom_polygon(data=get.poly(breaks[1],breaks[2]),aes(x,y),fill="red") +
    geom_polygon(data=get.poly(breaks[2],breaks[3]),aes(x,y),fill="gold") +
    geom_polygon(data=get.poly(breaks[3],breaks[4]),aes(x,y),fill="forestgreen")+
    geom_polygon(data=get.poly(pos-1,pos+1,0.2),aes(x,y)) +
    geom_text(data=as.data.frame(breaks),size=5,fontface="bold",vjust=0,
              aes(x=1.1*cos(pi*(1-breaks/100)),
                  y=1.1*sin(pi*(1-breaks/100)), label=paste0(breaks,"%"))) +
  annotate("text",x=0,y=0, label=pos,vjust=0,size=8,fontface="bold") +
  coord_fixed() +
  theme_bw() +
  theme(axis.text=element_blank(),
        axis.title=element_blank(),
        axis.ticks=element_blank(),
        panel.grid=element_blank(),
        panel.border=element_blank())


  
}

gg.gauge(52,breaks=c(0,35,85,100))
