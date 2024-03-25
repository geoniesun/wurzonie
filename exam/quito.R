#import riverse
library(sf)
library(dplyr)
library(rnaturalearth)
library(ggplot2)
setwd("E:/Eagle/courses/introprogramming/exam/")
rivers <- sf::st_read("rawdata/river_lines_0/River_lines.shp")

rivers
head(rivers)
plot(rivers)
View(rivers)

unique(rivers$NOMBRE_GEO)

#doesnt work
quito <- rivers[rivers$NOMBRE_GEO=="RÍO QUITO",]

#try out with dyplr
myquito <- rivers %>%
   filter(rivers$NOMBRE_GEO == "RÍO QUITO") 
myquito 
#it worked!

#lets plot myquito
plot(myquito)


colombia <- ne_countries(country = "Colombia", scale = "medium", returnclass = "sf")
colombia.r <- st_transform(colombia, st_crs(myquito))
plot(colombia)

#basic vis of river
ggplot(myquito) + geom_sf()

myquito_re <- sf::st_transform(myquito, 32618)
colombia_re <- sf::st_transform(colombia, 32618)


#overview where the river is
ggplot(data = colombia_re) +
  geom_sf() +
  geom_sf(data=myquito_re)
