# if 문

a <- 4
if (a>5) {
  print(a)
} else {
  print(a*10)
  print(a/10)
}


a <- 10
b <- 20
if (a>5 & b >5) {
  print(a+b)
} 
if (a > 5 | b>30) {
  print(a*b)
}


# 반복문

for (i in 1:10) {
  print(i)
}


i <- 1
while(i <= 10) {
  print(i)
  i <- i+1
}


for (i in 1:10) {
  cat("2 *",i,"=", 2*i,"\n")
}


for (i in 1:20) {
  if (i %% 2 == 0) {
    print(i)
  }
}



v1 <- 101:200
for(i in 1:length(v1)) {
  if(v1[i]%%2 == 0) {
    print(v1[i]*2)
  } else {
    print(v1[i]+2)
  }
}


sum <- 0
for(i in 1:100) {
  sum <- sum+i
}
print(sum)


mymax <- function(x,y) {
  num.max <- x
  if (y>x) {
    num.max <- y
    
  } 
  return(num.max)
}

mymax(10,15)
mymax(20,15)


n <- readline(prompt="숫자를 입력하세요: ")
cat("입력한 숫자는",n,"입니다. \n")


#연습문제
# 1
for (i in 1:100) {
  if (i %% 3 == 0) {
    print(i)
  }
}

# 2
for (i in 101:200) {
  if ((i %% 3 == 0) & (i %% 4 == 0)) {
    print(i)
  }
}

# 3
factorial1 <- function (n)
{
  if (n == 0) return (1)
  else {
    fact <- 1
    for (i in 1:n) fact <- fact * i
    return (fact)
  }
}
factorial1(6)

# 4
max1 <- function(a,b,c) {
  max = 0
  if ((a >= b) & (a >= b)) {
    max <- a
  } else if ((b >= a) & (b >= c)) {
    max <- b
  } else {
    max <- c
  }    
  print(max)
}

max1(10,100,2)
  


# 5
#윤년 체크 예제 
yun_func <- function(y){ 
  if(4 %% 4 == 0 & y %% 100 != 0 | y && 400 == 0) { 
    paste(y, '년은 윤년') 
  }
  else { 
    paste(y, '년은 평년') 
  } 
} 
yun_func(2222)


# 6
# 화면에서 숫자 2개 입력받아 두 숫자의 합과 곱 출력
#두 숫자가 모두 0이면 프로그램 중지

while(1) {
  a <- readline(prompt="숫자를 입력하세요.")
  A <- as.integer(a)
  b <- readline(prompt="숫자를 입력하세요.")
  B <- as.integer(b)
  
  print(A*B)
  print(A+B)
  
  if ((a == 0) & (b == 0)) {
    break
  } 
}
