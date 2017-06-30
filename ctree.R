install.packages("party")
library(party)
DataAct<-read.csv(file.choose(),header=T,sep=',')
str(DataAct)
model <- ctree(CODE_Medical ~ ., data=DataAct, control=ctree_control())
print(model)
plot(model,uniform=TRUE,main="Classification Tree with ctree")

