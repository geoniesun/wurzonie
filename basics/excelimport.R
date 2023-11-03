#importing a self created excel

#first you need to set your working directory
#getwd()
#setwd("...")


my.df <- read.csv("task2.csv", header = FALSE, sep = "/")
my.df

summary(my.df)
head(my.df)

mydf2 <- read.csv(file = "task2.csv")

mydf2

write.csv(x = mydf2, "mydf2.csv")
