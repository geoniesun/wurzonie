#fun lego 
# add images
#modern art
#color blind
#animate snow
#write emails

x1 <- rnorm(1000,0,1)
x2 <- rnorm(1000,5,10)
x3 <- rep(c("catA","catB","catC","catC","catC"),200)[1:1000]
x4 <- factor(rep(c("yes","no"),500))

df <- data.frame(a=x1, b=x2, c=x3, d=x4)

library(ggplot2)

#some art
pl <- ggplot(df, aes(a,b)) +
  geom_hex() +
  theme_bw()


devtools::install_github("gsimchoni/kandinsky")
library(kandinsky)
kandinsky(df)

#add images
install.packages("ggimage")

d <- data.frame(
  x = runif(10),
  y = runif(10)
)

library(ggimage, ggplot2)
ggplot(d, aes(x, y)) + geom_image(aes(image="C:/eagle/wurzonie/Rplot_kavinsky.jpg"), size=.5, by='height')


