rm(list=ls())
library(MASS)
head(geyser)
dim(geyser)
plot(geyser)

plot(geyser,xlim=c(30,120),ylim=c(0,6.5),col="forestgreen",pch=20,main="geyser")

library(KernSmooth)

density<-bkde2D(geyser,bandwidth=c(5,0.5))
par(new=T)
contour(density$x1,density$x2,density$fhat,xlim=c(30,120),ylim=c(0,6.5),
        col=heat.colors(7)[7:1],nlevels=7,lwd=2)
#Bivariate histogram
rm(list = ls())
library(lattice)
library(latticeExtra)
library(MASS)
library(KernSmooth)

#Univariate histogram
par(mfrow=c(1,2))
hist(geyser$waiting, nclass=20, main="geyser", xlab="waiting", xlim=c(40,120), ylim=c(0,80))
hist(geyser$duration, nclass=16, main="geyser", xlab="duration", xlim=c(0,8), ylim=c(0,80))

#Bivariate histogram
x.waiting<-cut(geyser$waiting,10)
levels(x.waiting)<-paste("w",1:10)
y.duration<-cut(geyser$duration,8)
levels(y.duration)<-paste("d",1:8)
geyser.freq<-table(x.waiting,y.duration)
geyser.freq

cloud(geyser.freq,panel.3d.cloud=panel.3dbars,main="geyser",xlab="waiting",ylab="duration",zlab="freq",
      zlim=c(0,max(geyser.freq)*1.5),scales=list(arrows=FALSE,just="right"),col.facet=level.colors(geyser.freq,
                                                                                                   at=do.breaks(range(geyser.freq),24),col.regions=terrain.colors,colors=TRUE),screen=list(z=30,x=-30))

#Square tile
rm(list = ls())
carb<-mtcars$carb
tbl<-table(carb)
prop<-round((tbl/sum(tbl))*100,digits=0)
sum(prop)
prop[3]<-prop[3]+1
m<-length(prop)

pie(prop,col=2:(m+1),main="carburators",labels=paste(names(tbl),"EA",prop))

barplot(prop,col=2:(m+1),main="carburators",ylim=c(0,40))

p.vec<-rep(1:m,prop)
P<-matrix(p.vec,10,10)
color<-2:(m+1)
par(mfrow=c(1,1))
image(P,col=color,axes=F,main="proportions")

abline(h=seq(-0.05,1.05,1.1/10),col="white",lwd=4)
abline(v=seq(-0.05,1.05,1.1/10),col="white",lwd=4)

#Mosaic plot
rm(list=ls())
head(mtcars)
par(mfrow=c(1,1))
mosaicplot(~gear+carb,data=mtcars,color=TRUE)

mosaicplot(~gear+carb,data=mtcars,color=c("red","green"))

Titanic
mosaicplot(Titanic,color=TRUE,off=5)

mosaicplot(Titanic,main="Survival on the Titanic",color=c("red","green"),off=1)

#tree map
library(treemap)
data(GNI2014)                # 데이터 불러오기 
str(GNI2014)                 # 데이터 내용보기 
treemap(GNI2014,
        index=c("continent","iso3"),
        vSize="population",  # 타일의 크기
        vColor="GNI",        # 타일의 컬러
        type="value",        # 타일 컬러링 방법
        bg.labels="yellow")  # 레이블의 배경색 

# 국가별 국민 총소득을 계산해서 GNI.total 컬럼에 저장
GNI2014$GNI.total <- GNI2014$population*GNI2014$GNI 
head(GNI2014)

# 국가별 국민 총소득을 대륙별로 합계내서 GNI2014.a 에 저장 
GNI2014.a <- aggregate(GNI2014[,4:6], by=list(GNI2014$continent),sum)

# 대륙별 합계를 대륙 인구수로 나누어 GNI.percap 컬럼에 저장
GNI2014.a$GNI.percap <- GNI2014.a$GNI.total/GNI2014.a$population

treemap(GNI2014.a,
        index=c("Group.1"),
        vSize="population",
        vColor="GNI.percap",
        type="value",
        bg.labels="red")
