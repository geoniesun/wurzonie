library(ggplot2)
library(prettymapr)
#packages
library(stars)
library(terra)
library(ggplot2)
library(RColorBrewer)
library(ggspatial)
library(basemaps)
library(sf)
library(ggmap)
library(rnaturalearth)
library(ggspatial)


library(rnaturalearth)


#changing layout settings here
setwd("E:/Eagle/courses/Active Remote Sensing Systems/MACKENNZIE")

file <- "E:/Eagle/courses/Active Remote Sensing Systems/MACKENNZIE/forlayoutbaltic/COH_sub.tif"
yourlegendtitle <- "Coherence"
yourlegendpalette <- "Greys" #or other
yourcrs <- 3857 #change if needed #25884 is baltic or 3857
yourfilename <- "baltic_overview.png"

#import raster

myraster <- terra::rast(file)


#plot(myraster) #first check but not necesssary

mydataframe <- as.data.frame(myraster, xy=T)%>%
  na.omit()
#plot(mydataframe)
#head(mydataframe)

#basemap

ext <- terra::ext(myraster)
ext <- terra::vect(ext)
ext <- sf::st_as_sf(ext)
ext <- st_set_crs(ext, 3857) 
ext <- sf::st_transform(ext,st_crs(europe))
extbox <- sf::st_bbox(ext)

plot(ext)
#set_defaults(map_service = "carto", map_type="dark")
#this is too heavy# set_defaults(map_service = "esri", map_type="world_imagery")
#basemap_magick(ext)



europe <- ne_countries(scale = 50, returnclass = "sf", continent = "Europe") 
europe_r <- sf::st_transform(europe, crs=3857)

ggplot(data = europe) +
  geom_sf()+
  coord_sf(xlim = c(5, 30), ylim = c(55, 71)) +
  theme_bw()+
  theme(legend.text = element_text("study site"))+
  geom_point(aes(x=25.14, y= 65.39), color="red", size=10)



ggplot(europe) +
  geom_sf()+
  coord_sf(xlim = c(5, 30), ylim = c(55, 71)) 

medium_scale_map <europemedium_scale_map <- ggplot(ext) +
  geom_sf(data = europe) +
  coord_sf(xlim = c(5, 30), ylim = c(55, 71)) 
  #ggtitle("Norden")

ggplot()+
  geom_point(aes(x=15, y= 60, color="red", size=10))

  ggplot(ext)
