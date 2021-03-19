# subway.csv 서울지하철역 및 시간대별 승하차 인원수 정보를 제공

# subway_latlong.csv 지하철 노선별 역이름 및 위치정보(위도,경도) 자료 및 각 역의 노선명

library(ggplot2)
library(ggmap)
register_google(key="AIzaSyB_bMR-O483kJLo_X5zEX7s0-VCVN3aQOM")


subway <- read.csv("subway.csv", header = TRUE, # csv파일 읽어들이기
                   stringsAsFactors = FALSE)
head(subway) # 시간대별 월별 년도별 승차인원
str(subway)

# income_date 변수를 R에서 처리할수 있게 표준 날짜형식으로 전환
class(subway[,"income_date"]) <- "character"
subway[ , "income_date"] <- as.Date(subway[ , 
       "income_date"], format = "%Y%m%d")
unique(format(subway[ , "income_Date"], "%Y"))


# 14년 자료 제외하고 2010~2013년까지 데이터는 subway2로 바꾸겠다.
idx <- format(subway[,"income_date"], "%Y") == "2014"
unique(format(subway[idx, "income_date"], "%m")) # 2014년 월에 대한 부분만 보겠다.
subway2 <- subset(subway, subset = 
                    format(income_date, "%Y") != "2014")

# subset 명령으로 2014년도 아닌 것만 취해서 subway2에 넣겠다

sort(unique(subway2[,'stat_name'])) 

# 환승역의 경우 노선번호가 붙어있음.
# 공덕(5), 공덕(6)은 분석에서는 동일한 역이므로 통일이 필요하다.
# 중복을 없애기 위해 (노선)를 없애 전처리하겠다.



# 역명에서 (노선)을 삭제하자.
idx <- grep("\\(", subway2$stat_name) # grep 명령어로 "\\(" 찾아서 그 행 번호를 idx에 저장
unique(subway2$stat_name[idx]) 

# ()를 제거한다. 역명에서 뒤의 3글자 제거
subway2$stat_name[idx] = 
  substr(subway2$stat_name[idx], # 중복된 역이름 중에 1열부터 뒤에 3글자(노선)를 삭제한다.
         1, nchar(subway2$stat_name[idx])-3)

# substr(x,1,5) : 문자열 x 에서 1~5자리의 문자를 자른다.



# 연도별, 월별 집계를 용이하도록 하기 위해, 연도, 월 컬럼을 추가한다.
year <- format(subway2$income_date, "%Y")
month <- format(subway2$income_date, "%m")
subway2 <- cbind(subway2, year, month)
head(subway2)


subname <- read.csv('subway_latlong.csv',
                    header=TRUE, stringsAsFactors = FALSE)
head(subname)


# 연도별, 역별 지하철 탑승객 수의 계산

tot <- aggregate(subway2[,"on_tot"],
                 by = list(stat_name = subway2$stat_name),
                 # stat_name을 기준으로 
                 FUN = sum) # on_tot(전체 승차 인원수)를 더한다.
 
tot # 전철역에 대해 승차한 총 인원수를 더한다. 2010~2013년까지 

# aggregate 함수는 특정 컬럼을 기준으로 데이터프레임의 값들을 집계(sum,mean)한다.
# head(iris)
# iris.avg <- aggregate(iris[,-5],  iris[,-5]는 집계대상컬럼
#     by = list(Species = iris$Species), # iris$Species는 집계기준컬럼
#     FUN = mean) mean은 집계 함수
# iris.avg
# by = list(Species = iris$Species)  Species는 일치시키는 것이 좋다.


# tot, subname 합병
cc= merge(x=tot, y=subname, by.x = "stat_name", # stat_name과 STATION_NM을 기준으로 합병
          by.y = "STATION_NM")
df2 <- data.frame(stat_name=cc$stat_name,
                  line_num=cc$LINE_NUM, on_tot=cc$x)
df2 <- df2[with(df2, order(line_num)),]

# 그래프 그리면 노선번호별로 역이 모이도록 하기 위함
df2$stat_name <- factor(df2$stat_name,
                        levels=df2$stat_name)


# 그래프 작성
plt <-ggplot(df2, aes(x=stat_name, y = on_tot,
             fill = line_num, order=line_num))
plt + theme_bw() + geom_bar(stat="identity", # bar형식으로 그래프 그린다. 자료의 데이털르 기반으로 y축의 높이를 지정한다.
  colour="white") +
  scale_x_discrete("지하철역", labels=df2$stat_name) +
  ylab("탑승객수") +
  scale_fill_discrete(name=c("노선"))


# (2) 탑승객수 상위 10개 역
df3 <- df2[order(-df2$on_tot),] # 내림차순 정렬, df3에 1행부터 10행까지 상위 10개역에 대한 정보 저장
df3 <- df3[1:10,]
df3$stat_name <- factor(df3$stat_name,  # 상위 10개의 항목을 많은 것부터 작 순서대로 표시
                        levels=df3$stat_name)

lim <- c(0,max(df3$on_tot)) # 컬럼값으로 벡터를 만드는데 승차인원 0부터 on_tot의 최대값까지 lim에 저장
plt <- ggplot(df3, aes(stat_name, y = on_tot,
                       fill=line_num)) # 호선 수에 따라 색칠한다.
plt + geom_bar(stat="identity", colour = "white") + 
  xlab("상위 10개 지하철역")  +
  scale_y_continuous("탑승객수",lim=lim) + # y축의 스케일 미리 지정한다. 최대한 표시할 수 있는 y축 한계값 lim값으로 지정한다. 
  scale_fill_discrete(name=c("노선"))  # 범례



# (3) 탑승객수 하위 10개역

df4 <- df2[order(df2$on_tot),] # 오름차순 정렬
df4 <- df4[1:10,]
df4$stat_name <- factor(df4$stat_name,
                        levels=df4$stat_name)
lim <- c(0,max(df2$on_tot))
plt <- ggplot(df4, aes(stat_name, y = on_tot,
                       fill=line_num))
plt + geom_bar(stat="identity", colour = "white") +
  xlab("하위 10개 지하철역") +
  scale_y_continuous("탑승객수",lim=lim) +
  scale_fill_discrete(name=c("노선")) 
 

# (4) 탑승객 상위 10개역의 2013년도 월별 승객 추이

ten.station <- df3$stat_name # 상위 10개 역 데이터

tmp <- subset(subway2, subset = stat_name %in% 
                ten.station & year == "2013",
                select=c("stat_name","on_tot","month"))
              
stat_top10_2013 <- aggregate(tmp$on_tot,
                             by=list(month=tmp$month, # 2013년 자료의 내용에서 월별 자료만 뽑아서
                                     stat_name=tmp$stat_name), # 전철역 이름에 대해 각 월별로
                             FUN=sum) # 다 더한다.
# by 명령에 의해서 전철역 이름에 대해서 각 월별로 더한다.
# 전철역 이름에 대하여 1월이면 1월 1일부터 31일까지의 데이터를 모두 다 더한 수를
# stat_top10_2013에 저장, stat_top10_2013의 3번째 칼럼에는 on_tot 값을 따로 컬럼바인딩해서 가질수 있게한다.
names(stat_top10_2013)[3] = "on_tot"


plt <- ggplot(stat_top10_2013, aes(x=month,
        y = on_tot, colour=stat_name, group=stat_name))
plt <- plt + theme_classic() + geom_line() +
  geom_point(size=6, shape=19, alpha=0.5)
plt + scale_x_discrete("2013년",
            labels=paste0(unique(as.numeric(month)), "월")) +
  ylab("월별 탑승객수") +
  scale_colour_discrete(name=c("지하철역"))

# 임의대로 색을 정하고(stat_name) , 전철역의 이름의 그룹으로 그림을 그리고
# plt에 계속 기능을 추가한다. (테마, 점, 라인 , alpha는 반투명)


# 2013년이란 제목을 달아주는데 월에 대한 내용을 수치상으로 뽑아서 숫자의 형태로 유일한 값인 1월~12월만 나오게
# 그 뒤에 paste로 "월"을 붙여준다.
# 범례에 대한 제목과 지하철 역에 각 월별 탑승객 수에 컬러를 지정(colour=stat_name)


# (5) 노선별 역당 평균 탑승객수의 계산 및 비교
subway3 <- merge(subway2, subname, # 전철역 이름에 맞춰 병합
          by.x = "stat_name",by.y="STATION_NM")

tmp1 <- aggregate(subway3[,"on_tot"], # subway3에서 탑승객 수만 뽑는데
                  # 호선 수와 전철역 이름을 기준으로 그 전철역의 전체 인원수를 구한다.  
                  by = list(LINE_NUM=subway3$LINE_NUM,
                            stat_name=subway3$stat_name),
                  FUN=sum,
                  na.rm=TRUE) # 해당되지 않는 자료는 제외한다.

# tmp1에는 1호선에 해당하는 ~역,~역등이 있다. 
# 그 1호선~모든 호선에 포함된 모든 역들의 승차인원에 대하여 평균 값 더하자

names(tmp1)[3] = "on_tot" # tmp1에 담고 tmp1의 3번째 컬럼에 on_tot를 배치시킨다.
tmp2 <- aggregate(tmp1[,"on_tot"], # 호선 수에 따라 평균값을 구한다.
                  by = list(LINE_NUM=tmp1$LINE_NUM),
                  FUN= mean,
                  na.rm=TRUE)
# tmp2에는 1호선이면 1호선들에 대한 전체 평균값~~~ 등이 담겨있다.
names(tmp2)[2] = "on_tot"
head(tmp2)

col <- c("red","springgreen2","orange","blue","purple",
         "brown","khaki","deeppink","yellow","deepskyblue")

# col 정보를 이용해서 pie 그래프 그린다.

pie(tmp2$on_tot,
    labels=paste0(unique(tmp2$LINE_NUM),"호선"),
    col=col,
    border="lightgray",
    main="노선별 평균 지하철 탑승객 수")

# (6) 노선별 누적 승객수의 상대 비교 , area 차트로 시각화
yearmonth <- paste(subway3$year, subway3$month,
                   "01", sep="-")
yearmonth <- as.Date(yearmonth) 
tmp3 <- cbind(subway3, yearmonth) 
tmp3$LINE_NUM <- paste0(tmp3$LINE_NUM,"호선")
tmp4 <- aggregate(tmp3[,"on_tot"], # 연도와 월 정보를 기준으로 전체 승차 인원수 구한다.
                  by=list(LINE_NUM=tmp3$LINE_NUM,
                          yearmonth=tmp3$yearmonth),
                  FUN=sum,
                  na.rm=TRUE)

names(tmp4)[3] = "on_tot" #tmp4의 3번째 열에 내용에 on_tot 이름을 붙여준다.



plt <- ggplot(tmp4, aes(x=yearmonth, y = on_tot, # x축은 yearmonth, y축은 승차 인원수
                        fill=LINE_NUM)) #노선번호 별로 색 칠한다.
plt <- plt + geom_area(colour="white",size=0.2)
plt <- plt + scale_fill_manual(name="노선",
                               values=col)
plt + theme_classic() + xlab("YEAR") + ylab("누적 승객수")



# 구글맵 위에 탑승객수 매핑
library(ggmap)
dat1 <- subset(subway3, income_date=="2012-06-10",  # 최종 데이터가 subway3
  select=c("XPOINT_WGS", "YPOINT_WGS", "on_tot", "stat_name", "LINE_NUM"))
# 특정날을 지정하고 해당 전철역의 위도,경도 정보, 전체 승객수, 전철 이름, 호선번호 정보만 부분집합으로 떼어낸다.
Map_Seoul <- get_map(location=c(lat=37.55, lon=126.97), zoom=11, maptype="roadmap") # 서울역의 위도 경도
MM <- ggmap(Map_Seoul)
MM2 <- MM+geom_point(aes(x=YPOINT_WGS, y=XPOINT_WGS, size=on_tot, 
                         colour=as.factor(LINE_NUM)), data=dat1)
MM2 + scale_size_area(name=c("탑승객수")) + scale_colour_discrete(name=c("노선")) + labs(x="경도", y="위도")



# (8) 2013년도의 탑승객 수의 상위 10개역을 지도에 시각화

stat_top10_2013 <- subset(subway2, subset=
                            year=="2013" & stat_name %in% ten.station)

dat2 <- aggregate(stat_top10_2013[,"on_tot"],
                  by = list(stat_name=stat_top10_2013$stat_name),
                  FUN=sum) # 승차인원 수에 대한 내용을 전철역의 이름을 기준으로 다 더한다.

names(dat2)[2] = "on_tot" 
dat2 <- merge(dat2, subname, by.x="stat_name", # subname에 전철역의 위도 경도값 정보를 담고 있다.
              by.y="STATION_NM") 

# 상위 10개 전철역 이름과 전철역의 전체 승차인원, 그에 맞는 위도,경도가 각각의 컬럼의 존재


Map_Seoul <- get_map(location=c(lon=126.97,
                lat=37.55), zoom=11, maptype="roadmap")
MM <- ggmap(Map_Seoul) # 서울지도 만들기
MM3 <- MM + geom_point(aes(x=YPOINT_WGS,
                       y=XPOINT_WGS, size=on_tot), alpha=0.5, # 투명도는 0.5
                       data=dat2)

MM3 + scale_size_area(name=c("탑승객수"), 
                    max_size=15) + geom_text(aes(x=YPOINT_WGS,y=XPOINT_WGS,
                    label=stat_name),
                    colour="red",vjust=3,size=3.5,
                    fontface="bold", data=dat2) + labs(x="경도", y="위도")
