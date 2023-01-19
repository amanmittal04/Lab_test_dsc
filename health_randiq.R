library(caTools)
library(randomForest)

dataset <- read.csv("health.csv")

head(dataset)
str(dataset)

dataset$Diabetes <- as.numeric(factor(dataset$Diabetes))
split <- sample.split(dataset,SplitRatio = 0.7)
split

train <- subset(dataset,split=="TRUE")
test <- subset(dataset,split=="FALSE")
train
test

model <- randomForest(x=train[-5],y=train$Diabetes,ntree = 500)
model

y_pred <- predict(model,newdata = test[-5])
y_pred

confusion_mtx <- table(test$Diabetes,y_pred)
confusion_mtx

plot(model)
importance(model)
varImpPlot(model)

