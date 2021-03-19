library('tm')            # 텍스트 마이닝(말뭉치)
library('wordcloud')     # 워드클라우드 작성
library('RColorBrewer')  # 단어의 색 처리


# 텍스트 파일 가져오기
data <- readLines(file.choose())

# 말뭉치 생성
corp <- Corpus(VectorSource(data))



########### 말뭉치 처리 단계 ###########

# 여러 개의 공백을 하나의 공백으로 압축
corp <- tm_map(corp, stripWhitespace)

# 숫자 제거
corp <- tm_map(corp, removeNumbers)

# 특수문자 제거
corp <- tm_map(corp, removePunctuation)

# 대문자를 소문자 변환
corp <- tm_map(corp, tolower)

# 각종 불필요한 단어들 제거
sword <- c(stopwords("en"),"will","can","and","but","not")
corp <- tm_map(corp, removeWords, sword)



########## 워드 클라우드 생성 ##########

# 팔레트 생성
pal2 <- brewer.pal(8,"Dark2")

# 워드 클라우드 생성
wordcloud(corp,            # 말뭉치
        scale=c(3,0.5),  # 빈도가 가장 큰 단어와 가장 작은 단어 폰트 크기 차이
        min.freq=2,      # 표시할 단어의 최소 빈도: 2
        random.order=F,  # 빈도가 큰 단어일 수록 중앙 배치
        random.color=F,  # 빈도에 따라 색상 결정
        rot.per = .1,    # 90도 회전되는 단어의 비율: 10%
        colors=pal2      # 단어색 팔레트
)

