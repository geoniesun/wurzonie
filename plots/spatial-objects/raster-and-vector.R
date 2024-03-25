#plotting raster and vecotr

library(raster)
library(ggplot2)
library(RStoolbox)
library(rnaturalearth)
library(geodata)

world <- ne_countries(scale="medium", returnclass = "sf")
ger <- world[world$name=="Germany"]
library(ggspatial)

ggplot(data=ger) + geom_sf() #just some vector data

#put raster data on top.
#no actual data is put in this script
ggplot(data=ger) +ggR(rasterData, geom_raster = T, ggLayer=T) +geom_sf(fill=...)

#for different color schemes
  +scale_fill_manual()

#for text on map
  + geom_text_repel()

#for scale bar
  +scale()
#for north arrow
  +annotation_north_arrow()
#if required: convert from sp to sf and vice versa
st_as_sf()
