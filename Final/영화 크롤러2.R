library(XML)
library(stringr)

all_reviews <- NULL
url_base <- "https://movie.naver.com/movie/bi/mi/pointWriteFormList.nhn?code=189001&type=after&onlyActualPointYn=N&order=newest&page="

for (i in 1:2) {
  temp <- NULL
  url <- paste(url_base, i, sep='')
  txt <- readLines(url, encoding="utf-8")
  
  points <- txt[which(str_detect(txt, "class=\"star_score\""))+2]
  points <- gsub("<.+?>|\t","", points)
  points <- points[c(2:11)]  #한 리뷰 페이지당 데이터가 11건이 나옴 (첫번째의 불필요한행 존재. 때문에 2번째 행부터 11번째 행의 값만 가져옴)
  
  reviews <- txt[which(str_detect(txt, "class=\"score_reple\""))+1]
  reviews <- gsub("<.+?>|\t","", reviews)
  
  temp <- cbind(points, reviews)
  all_reviews <- rbind(all_reviews, temp)
}





print(all_reviews)



