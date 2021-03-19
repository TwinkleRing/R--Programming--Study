install.packages("RColorBrewer")

library(KoNLP)

library(wordcloud)
library(RColorBrewer)


useSejongDic() # 세종 한글사전 로딩
pal2 <- brewer.pal(8,"Dark2") # 팔레트 생성
text <- readLines(file.choose())
noun <- sapply(text,extractNoun, USE.NAMES = F)

head(noun)

noun2 <- unlist(noun)
wordcount <- table(noun2)
wordcount
sort(wordcount, decreasing = T)[1:10] # 1등부터 10등까지
wordcloud(names(wordcount),
          freq=wordcount,
          scale=c(6,0.7),
          min.freq=3,
          random.order = F,
          rot.per = .1,
          colors=pal2)


mergeUserDic(data.frame(c("정치"),c("ncn")))
noun <- sapply(text,extractNoun, USE.NAMES = F)
noun2 <- unlist(noun)

# 무의미한 단어 제거
noun2 <- noun2[nchar(noun2)>1] # 인덱스 번호만 취해서 저장
noun2 <- gsub("국민","",noun2)
noun2 <- gsub("여러분","",noun2)

wordcount <- table(noun2)
wordcloud(names(wordcount),
          freq=wordcount,
          scale=c(6,0.7),
          min.freq=3,
          random.order = F,
          rot.per=.1,
          colors=pal2)

