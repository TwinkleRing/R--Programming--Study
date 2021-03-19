## ----echo=F,message=FALSE------------------------------------------------
library(ggplot2)
library(NIADic)
library(data.table)
library(scales)

total_dt <- data.table(get_dic("woorimalsam"))

## ----echo=FALSE----------------------------------------------------------


ggplot(total_dt[,.N,.(tag)], aes(x=reorder(tag, N), N)) +geom_bar(stat='identity') + xlab("KAIST tag") + coord_flip() + ggtitle("Tag frequency") + scale_y_continuous(labels = comma)


knitr::kable(total_dt[,.N,category][order(-N)])

ggplot(total_dt[,.N,category], aes(x=reorder(category, N), N)) +geom_bar(stat='identity') + xlab("category") + coord_flip() + ggtitle("category frequency") +  scale_y_continuous(labels = comma)

## ---- echo=FALSE---------------------------------------------------------
knitr::kable(total_dt[category %chin% '법률'][sample(nrow(total_dt[category %chin% '법률']), 10)], caption="법률용어 예시")

knitr::kable(total_dt[category %chin% '의학'][sample(nrow(total_dt[category %chin% '의학']), 10)],  caption="의학용어 예시")


