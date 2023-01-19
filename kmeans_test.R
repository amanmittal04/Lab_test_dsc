library(dplyr)
library(ggfortify)
library(ggplot2)
dt <- read.csv("test_xy.csv")
dt


wssplot <- function(dt, nc=5, seed=1234){
  
  wss <- (nrow(dt)-1)*sum(apply(dt,2,var))
  
  for (i in 2:nc){
    set.seed(seed)
    wss[i] <- sum(kmeans(dt, centers=i)$withinss)
  }
  
  plot(1:nc, wss, type="b", xlab="Number of Clusters", ylab="Within groups sum of squares")
  
  wss
  
}

wssplot(dt)
kmean <- kmeans(dt,2)
kmean$centers
autoplot(kmean,dt,frame = TRUE)

kmean <- kmeans(dt,3)
kmean$centers
autoplot(kmean,dt,frame = TRUE)
