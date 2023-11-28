#3D plots



x1 <- rnorm(1000,0,1)
x2 <- rnorm(1000,5,10)
x3 <- rep(c("catA","catB","catC","catC","catC"),200)[1:1000]
x4 <- factor(rep(c("yes","no"),500))

df <- data.frame(a=x1, b=x2, c=x3, d=x4)


library(ggplot2)

##1#Hexbin
ggplot(df, aes(a,b)) +
  geom_hex() +
  theme_bw()

#devtools::install_github("tylermorganwall/rayshader")
#install.packages("rayshader")

library(rayshader)
#Lines
pp = ggplot(df, aes(x=a, y=b)) +
  geom_hex()
  ##scale_fill_viridis_c(option = "C")
pp
pp2 <- plot_gg(ggobj = pp)

#No lines
pp_nolines = ggplot(df, aes(x=a, y=b)) +
  geom_hex(bins = 20, size = 0) +
  scale_fill_viridis_c(option = "C")
plot_gg(pp_nolines)



