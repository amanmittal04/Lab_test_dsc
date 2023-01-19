# Installing the package
install.packages("dplyr")
install.packages("caTools") # For Logistic regression
install.packages("ROCR")	 # For ROC curve to evaluate model

# Loading package
library(dplyr)
library(caTools)
library(ROCR)

# Summary of dataset in package
dt <- read.csv("weather.csv")
dt
# Splitting dataset
split <- sample.split(dt, SplitRatio = 0.8)
split

train_reg <- subset(dt, split == "TRUE")
test_reg <- subset(dt, split == "FALSE")

# Training model
logistic_model <- glm(Rain ~ temperature + humidity,
                      data = train_reg,
                      family = "binomial")
logistic_model

# Summary
summary(logistic_model)

# Predict test data based on model
predict_reg <- predict(logistic_model,
                       test_reg, type = "response")
predict_reg

# Changing probabilities
predict_reg <- ifelse(predict_reg >0.7, 1, 0)
predict_reg

# Evaluating model accuracy
# using confusion matrix
table(test_reg$Rain, predict_reg)

missing_classerr <- mean(predict_reg != test_reg$Rain)
print(paste('Accuracy =', 1 - missing_classerr))

# ROC-AUC Curve
ROCPred <- prediction(predict_reg, test_reg$Rain)
ROCPer <- performance(ROCPred, measure = "tpr", x.measure = "fpr")
plot(ROCPer)

auc <- performance(ROCPred, measure = "auc")
auc <- auc@y.values[[1]]
auc

# Plotting curve

plot(ROCPer, colorize = TRUE, main = "ROC CURVE")
abline(a = 0, b = 1)

auc <- round(auc, 4)
legend(.6, .4, auc, title = "AUC", cex = 1)
