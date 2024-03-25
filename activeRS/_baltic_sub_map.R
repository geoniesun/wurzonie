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
library(prettymapr)
library(tmap)   # for static and interactive maps


#changing layout settings here
setwd("E:/Eagle/courses/Active Remote Sensing Systems/MACKENNZIE")

file <- "E:/Eagle/courses/Active Remote Sensing Systems/MACKENNZIE/forlayoutmack/highcoh_subset_better.tif"
yourlegendtitle <- "Coherence"
yourlegendpalette <- "Greys" #or other and add trans = "reverse" if using Spectral
yourcrs <- 25884 #change if needed #25884 is baltic or 3857
yourfilename <- "highcoherence_mackenzie_plot.png"

#import raster

myraster <- terra::rast(file)


#plot(myraster) #first check but not necesssary

mydataframe <- as.data.frame(myraster, xy=T)#%>%na.omit()


#basemap with ggspatial
#install.packages("prettymapr")
#library(prettymapr)
#https://biostats-r.github.io/biostats/workingInR/140_maps.html



myplot <- ggplot() +
  annotation_map_tile(
    type="cartolight",
    cachedir = "maps/", 
    zoomin=0) +
  geom_raster(data = mydataframe, aes(x = x, y = y, fill = mydataframe[,3])) +
  scale_fill_distiller(palette=yourlegendpalette) +
  labs(fill = yourlegendtitle) +
  theme(legend.position = "bottom",
        legend.justification = "left", 
        legend.direction = "horizontal",
        axis.title=element_blank(),
        axis.text.y = element_text(angle = 90)) +
  coord_sf(crs = yourcrs) +
  annotation_scale(location= "bl",width_hint=0.5) +
  annotation_north_arrow(location="tr",pad_x = unit(0.0, "in"),
                         pad_y = unit(0.1, "in"),style=north_arrow_fancy_orienteering())

ggsave(yourfilename, plot = last_plot(), width=5, height = 7, path = "E:/Eagle/courses/Active Remote Sensing Systems/MACKENNZIE/")
