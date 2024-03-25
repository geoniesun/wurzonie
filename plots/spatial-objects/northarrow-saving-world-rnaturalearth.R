# plotting sf and rnaturalearth
 
library(ggspatial)
library(libwgeom)
library(cowplot)
library(ggrepel)

world <- ne_countries(scale="medium", returnclass = "sf")
#first overview
class(world)
ggplot(data=world) + geom_sf()

#go further
ggplot(data=world) + 
  geom_sf(color = "grey", fill = "darkgreen")


ggplot(data=world) + 
  geom_sf(aes(fill=pop_est)) +
  scale_fill_viridis_c(option="inferno", trans="sqrt")

#make it a KUGEL!!
ggplot(data=world) + 
  geom_sf() +
  coord_sf(crs = "+proj=laea +lat_0=52 +lon_0=10 +x_0=4321000 +y_0=3210000 +ellps=GRS80 +units=m
           +no_defs ")

#only germany with north arrow and scale
ger <- world[world$name=="Germany"]
library(ggspatial)
ggplot(data=ger) +
  geom_sf() +
  annotation_scale(location = "bl", width_hint=0.5) +
  annotation_north_arrow(location = "bl", which_north ="true",
                         pad_x = unit(0.2, "in"), pad_y = unit(0.5, "in"),
                         style = north_arrow_fancy_orienteering)

ggsave("map.pdf")
ggsave("map_web.png", width = 6, height = 6, dpi = "screen")
