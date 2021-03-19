library(ggmap)
library(ggplot2)

register_google(key="AIzaSyB_bMR-O483kJLo_X5zEX7s0-VCVN3aQOM")

names <- c("1. ❤소혀니네 집❤")
addr <- c("도봉구 방학로 200")
gc <- geocode(enc2utf8(addr))
gc
df <- data.frame(name=names,
                 lon=gc$lon,
                 lat=gc$lat)
df


cen <- c(mean(df$lon),mean(df$lat))
map <- get_googlemap(center=cen,
                     maptype = "roadmap",
                     zoom = 17,
                     marker = gc)
ggmap(map)

gmap <- ggmap(map)
gmap + geom_text(data=df,
                 aes(x=lon,y=lat),
                 size=5,
                 label=df$name)
