## ----echo=F,message=FALSE------------------------------------------------
library(ggplot2)
library(NIADic)
library(data.table)
library(scales)

total_dt <- data.table(get_dic("insighter"))

## ----echo=FALSE----------------------------------------------------------

ggplot(total_dt[,.N,.(tag)], aes(x=reorder(tag, N), N)) +geom_bar(stat='identity') + xlab("KAIST tag") + coord_flip() + ggtitle("Tag frequency") + scale_y_continuous(labels = comma)


ggplot(total_dt[,.N,in_category], aes(x=reorder(in_category, N), N)) +geom_bar(stat='identity') + xlab("category") + coord_flip() + ggtitle("NIA dictionary  category frequency") +  scale_y_continuous(labels = comma)


## ---- echo=FALSE---------------------------------------------------------
knitr::kable(total_dt[in_category %chin% 'place_name'][sample(nrow(total_dt[in_category %chin% 'place_name']), 10)], caption="위치 예시")

knitr::kable(total_dt[in_category %chin% 'brand_name'][sample(nrow(total_dt[in_category %chin% 'brand_name']), 10)],  caption="브랜드명 예시")


