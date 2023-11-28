a <- c(1.3,3.4,2.4,2.9)
is.numeric(a)
typeof(a)
class(a)
a[1] <- "1.2"
is.numeric(a)
typeof(a)
class(a)


b <- letters[1:10]
is.character(b)
typeof(b)

b[1] <- 1
is.character(b)
typeof(b)


d <- c(TRUE, TRUE, TRUE, TRUE, FALSE, TRUE)
is.logical(d)
typeof(d)
class(d)

d[1] <- 1
is.logical(d)


year <- 2023
x <- "EAGLE students"
paste("The", year, x, "like to code :-)")


#never do
x <- "0.3"
y <- 0.01
y < x

x <- "0.3"
y <- 0.000001
y < x


install.packages("ggplot2")
library(ggplot2)
x <- data.frame(x=1,y=1,label="Å")
ggplot(data=x, aes(x=x, y=y)) + geom_text(aes(label=label), size=15)


