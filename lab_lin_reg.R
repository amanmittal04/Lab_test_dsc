install.packages("ggplot2")
library("ggplot2")
dt <- read.csv("weather.csv")
dt
dt['x']
dt['y']

x <- dt[-4]
y <- dt$Rain
x
y
#Apply lm function
relation <- lm(y~temperature,data=dt)

relation
summary(relation)

#Find weight of a person with height 5.6
a <- data.frame(temperature=5.6)
result <- predict(relation,a)
print(result)

# Giving a name to the chart file.  
png(file = "linear_regression.png")  
# Plotting the chart.  
plot(y,dt$temperature,col = "red",main = "Temperature and Rain Regression",abline(lm(dt$temperature~y)),cex = 1.3,pch = 16,xlab = "temperature in C",ylab = "Rain")  

# Saving the file.  
dev.off()  
