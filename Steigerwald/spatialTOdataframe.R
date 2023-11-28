library(RCurl)
library(ggplot2)
library(sf)

df <- read.csv("https://raw.githubusercontent.com/wegmann/R_data/master/Steigerwald_sample_points_all_data_subset_withNames.csv", header = TRUE)

df


head(df)
summary(df)
tail(df)
plot(df)
str(df)

#this is from Martin: we check fist que onda
names(df)
head(df)
#then we create an empty plot
ggplot(df, aes(x=L8.ndvi, y=L8.savi)) + geom_point()

df <- df[1:100,]

df.sf <- st_as_sf(x = df,
                  coords = c("x", "y"),
                  crs = 'epsg:32632'
                  ) #32632
st_write(df.sf, "./steigerwaldspatial7.gpkg")


pack <- read_sf("./steigerwaldspatial7.gpkg")
str(pack)

pack2 <- data.frame(pack)
str(pack2)
View(pack)
str(pack)



library(ggplot2)
#install.packages("ggspatial")
#install.packages("basemaps")
library(basemaps)

#library(maps)
library(ggspatial)
data(ext)
plot(df.sf)

ggplot(data = df.sf, aes(color=LCname)) + geom_sf() +
  geom_point(aes(size = SRTM))

#try only one variable





# or use draw_ext() to interactively draw an extent yourself

# view all available maps
get_maptypes()

# set defaults for the basemap
set_defaults(map_service = "osm", map_type = "topographic")

# load and return basemap map as class of choice, e.g. as image using magick:
basemap_magick(ext)
#> Loading basemap 'topographic' from map service 'osm'...
#> 

ggplot(data = df.sf) +
  geom_sf() +
  basemap_gglayer(ext) +
  annotation_scale(location = "br", width_hint = 0.3) +
  annotation_north_arrow(location = "br", which_north = "true",
                         pad_x = unit(0.2, "in"), pad_y = unit(0.5, "in"),
                         style = north_arrow_fancy_orienteering)
basemap_plot(ext)

install.packages("OpenStree")