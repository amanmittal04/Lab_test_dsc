install.packages("arules")
install.packages("arulesViz")
library(arules)
library(arulesViz)

dataset = read.transactions("Market_Basket_Optimisation.csv",sep=",",rm.duplicates = TRUE)
str(dataset)
dataset

set.seed(200)
associa_rules = apriori(data = dataset,parameter = list(support=0.004,confidence = 0.2))

itemFrequencyPlot(dataset, topN = 10)

options(ggrepel.max.overlaps = Inf)
inspect(sort(associa_rules,by = 'lift')[1:10])
plot(associa_rules,method = "graph",measure = "confidence",shading = "lift")
