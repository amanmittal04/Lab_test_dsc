library(caTools)
library(dplyr)
library(ROCR)

data<-read.csv("weather1.csv")
head(data)

split<-sample.split(data,SplitRatio = 0.7)
split

train<-subset(data,split==TRUE)
test<-subset(data,split==FALSE)

model<-glm(Rain~.,data = train,family=binomial)
model
summary(model)

p<-predict(model,test,type = "response")
p

pr<-prediction(p,test$Rain)
prf<-performance(pr,"tpr","fpr")
plot(prf)

auc<-performance(pr,"auc")
auc<-auc@y.values[[1]]
auc

missing_classerr <- mean(p != test$Rain)
print(paste('Accuracy =', 1 - missing_classerr))

