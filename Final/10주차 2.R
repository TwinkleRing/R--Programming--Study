# 여러 지역의 마커 표시하기
library(ggmap)
library(ggplot2)

register_google(key="AIzaSyB_bMR-O483kJLo_X5zEX7s0-VCVN3aQOM")

names <- c("1. 도담삼봉/석문","2. 구담/옥순봉","3. 사인암",
           "4. 하선암","5. 중선암","6. 상선암")

addr <- c("매포음 삼봉로 644-33",
          "단성면 월악로 3827",
          "대강면 사인암2길 42",
          "단성면 선암계곡로 1337",
          "단성면 선암계곡로 868-2",
          "단성면 선암계곡로 790")
gc <- geocode(enc2utf8(addr))
gc
df <- data.frame(name=names,
                 lon=gc$lon,
                 lat=gc$lat)
df


cen <- c(mean(df$lon),mean(df$lat))
map <- get_googlemap(center=cen,
                     maptype = "roadmap",
                     zoom = 11,
                     marker = gc)
                       

ggmap(map)


# 명소 이름 지도위에 표시하기
gmap <- ggmap(map)
gmap + geom_text(data=df,
                 aes(x=lon,y=lat),
                 size=5,
                 label=df$name)



# 지진 발생 데이터(quakes)
quakes
head(quakes) # 위도/경도/진앙지 깊이/지진규모(진도)/관측지

df <- head(quakes,100)
cen <- c(mean(df$long), mean(df$lat))
gc <- data.frame(lon=df$long, lat=df$lat)
gc$lon <- ifelse(gc$lon>180, -(360-gc$lon),gc$lon)
gc
map <- get_googlemap(center=cen,
       maptype = "roadmap",
       zoom = 4,
       marker = gc)

ggmap(map, extent="device")


map <- get_googlemap(center=cen,
                     maptype = "roadmap",
                     zoom=5)
gmap <- ggmap(map)
gmap + geom_point(data=df,
                  aes(x=long,y=lat, size=mag),
                  alpha=0.5)

