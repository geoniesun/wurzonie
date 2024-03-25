#to create layouts for my active remote senisng exam

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


#changing layout settings here
setwd("E:/Eagle/courses/Active Remote Sensing Systems/MACKENNZIE")
file <- "E:/Eagle/courses/Active Remote Sensing Systems/MACKENNZIE/forlayoutbaltic/COH_sub.tif"
yourlegendtitle <- "Coherence"
yourlegendpalette <- "Greys" #or other
yourcrs <- 3857 #change if needed #25884 is baltic

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
ext <- st_set_crs(ext, 25884) 

#set_defaults(map_service = "carto", map_type="dark")
#this is too heavy# set_defaults(map_service = "esri", map_type="world_imagery")
#basemap_magick(ext)

##basemap with rnaturalearth
coast <- ne_download(scale=50,type="coastline", category = "physical")

#basemap with ggspatial
#install.packages("prettymapr")
library(prettymapr)



basemap <- ggplot() +
  annotation_map_tile(
    type="cartodark",
    cachedir = "maps/",
    zoomin=-1) +
  theme_void() +
  coord_sf(xlim = c(533125.9, 561407.5), 
           ylim = c(7245681, 7280149),crs=25884
  ) #works!


#this works!
myplot <- 
  ggplot(data = mydataframe) +
  geom_raster(aes(x = x, y = y, fill = mydataframe[,3])) +
  scale_fill_distiller(palette=yourlegendpalette) +
  theme_bw() +
  labs(fill = yourlegendtitle) +
  theme(legend.position="bottom", legend.direction = "horizontal", axis.title=element_blank()) +
  coord_sf(crs = yourcrs) +
  annotation_scale(location= "bl",width_hint=0.2) +
  annotation_north_arrow(location="br",pad_x = unit(0.5, "in"),
                         pad_y = unit(0.1, "in"),style=north_arrow_orienteering()) 

layout <- basemap +
  annotation_custom(grob=ggplotGrob(myplot))

