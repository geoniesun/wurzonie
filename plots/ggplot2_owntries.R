#help about geoms
help.search("geom_", package = "ggplot2")

#examples for ggplot2

x1 <- rnorm(1000,0,1)
x2 <- rnorm(1000,5,10)
x3 <- rep(c("catA","catB","catC","catC","catC"),200)[1:1000]
x4 <- factor(rep(c("yes","no"),500))

df <- data.frame(a=x1, b=x2, c=x3, d=x4)

library(ggplot2)
ggplot(df, aes(a, b)) + geom_point(aes())

#color
ggplot(df, aes(a,b,color=c)) + geom_point()

#setting color translucency to 0.5
ggplot(df, aes(a,b,color=c)) + geom_point(alpha=.5)

#adding a title and x axis label:
ggplot(df, aes(a,b,color=c)) +
  geom_point(alpha=5) +
  labs(title = "first plot", x = "x axis \n and a new line")


ggplot(df, aes(b) ) + geom_histogram(color="white")

ggplot(df, aes(c)) + geom_density()

ggplot(df) + geom_histogram(aes(a, ..density..), fill="blue", colour="darkgrey") +
  geom_density(aes(a, ..density..), colour="yellow") +
  geom_rug( aes(a))

#a plot with just statistics
ggplot(df, aes(c, color=c)) + geom_point(stat = "count", size = 4)




