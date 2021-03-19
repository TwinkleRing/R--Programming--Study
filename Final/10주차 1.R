library("ggmap")
register_google(key="AIzaSyB_bMR-O483kJLo_X5zEX7s0-VCVN3aQOM")
gc <- geocode(enc2utf8("용인"))
gc
cen <- as.numeric(gc)
cen
map <- get_googlemap(center=cen,
       maptype="roadmap",
       marker=gc) #용인의 경도,위도값 찾아서 그 위치에 마킹
ggmap(map)




names <- c("용두암","성산일출봉","정방폭포",
           "중문관광단지","한라산1100고지","차귀도")
addr <- c("제주시 용두암길 15",
          "서귀포시 성산읍 성산리",
          "서귀포시 동홍동 299-3",
          "서귀포시 중문동 2624-1",
          "서귀포시 색달동 산1-2",
          "제주시 한경면 고산리 125")

gc <- geocode(enc2utf8(addr))
gc
df <- data.frame(name=names,
                 lon=gc$lon,
                 lat=gc$lat)
df

cen <- c(mean(df$lon), mean(df$lat))

map <- get_googlemap(center=cen,
                     maptype = "roadmap",
                     zoom=10,
                     size=c(640,640),
                     marker=gc)
ggmap(map)


gc <- geocode(enc2utf8("설악산"))
cen <- as.numeric(gc)
map <- get_googlemap(center=cen,
                     zoom=8,
                     size=c(640,640),
                     maptype = "hybrid")
ggmap(map)



cen <- c(-118.233248,34.085015) # LA
map <- get_googlemap(center=cen)
ggmap(map)


names <- c("용두암","성산일출봉","정방폭포",
           "중문관광단지","한라산1100고지","차귀도")
addr <- c("제주시 용두암길 15",
          "서귀포시 성산읍 성산리",
          "서귀포시 동홍동 299-3",
          "서귀포시 중문동 2624-1",
          "서귀포시 색달동 산1-2",
          "제주시 한경면 고산리 125")

gc <- geocode(enc2utf8(addr)) # 주소를 경도,위도로 변환
gc
df <- data.frame(name=names,
                 lon=gc$lon,
                 lat=gc$lat)
df

cen <- c(mean(df$lon),mean(df$lat))
map <- get_googlemap(center = cen,
                     maptype = "roadmap",
                     zoom= 10,
                     size=c(640,640),
                     marker=gc)
ggmap(map)
# 명소이름 지도 위에 표시하기.
gmap <- ggmap(map)
gmap+geom_text(data=df,
               aes(x=lon,y=lat),
               size=5,
               label=df$name)
