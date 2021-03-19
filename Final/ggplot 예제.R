library(ggmap)
library(ggplot2)

register_google(key="AIzaSyB_bMR-O483kJLo_X5zEX7s0-VCVN3aQOM")


ggplot(data=iris,
       aes(x=Petal.Length, y = Petal.Width))+
       geom_point(aes(color=Species, shape = Species),
                  alpha=0.5,
                  size=2) +
       ggtitle("IRIS data") +
       theme(plot.title = element_text(size=14,
                                       face="bold",color="blue",hjust = 0.5)) +
       xlab("꽃잎의 길이") +
       ylab("꽃잎의 폭")

# 막대그래프 가로로 표현하기
df = data.frame(table(mtcars$carb))
df
ggplot(df,aes(x=Var1, y=Freq)) +
    geom_bar(stat="identity", width=0.7,
             fill= "steelblue") +
  coord_flip()

# 그룹별 히스토그램 1
ggplot(iris, aes(x=Petal.Length,
                 fill=Species, color=Species))+
    geom_histogram(position="stack")


# 그룹별 히스토그램 2
ggplot(iris, aes(x=Petal.Length,
                 fill=Species, color=Species))+
  geom_histogram(position="dodge")


