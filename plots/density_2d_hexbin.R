##hexbin chart
#AND
#density geo chart


#help about geoms
help.search("geom_", package = "ggplot2")

#examples for ggplot2

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
#bin size control + color palette
ggplot(df, aes(a,b)) +
  geom_hex(bins = 70) +
  scale_fill_continuous(type = "viridis") +
  theme_bw()

##2#gweom_density
ggplot(df, aes(a, b) ) +
  geom_density_2d()

# Show the area only
ggplot(df, aes(a, b) ) +
  stat_density_2d(aes(fill = ..level..), geom = "polygon")

# Area + contour
ggplot(df, aes(a, b))+
  stat_density_2d(aes(fill = ..level..), geom = "polygon", colour="white")


# Using raster
ggplot(df, aes(a, b) ) +
  stat_density_2d(aes(fill = ..density..), geom = "raster", contour = FALSE) +
  scale_x_continuous(expand = c(0, 0)) +
  scale_y_continuous(expand = c(0, 0)) +
  theme(
    legend.position='none'
  )


#make some 3d
ggplot(df, aes(a,b)) +
  geom_hex() +
  theme_bw()

plot_gg(df)
