library(devtools)
library(remotes)
install.packages("cartography")
#download the dev version of cartography
remotes::install_github("riatelab/cartography")
library(cartography)
library(sf)
# import a vector layer (here a shapefile)
mtq <- st_read(system.file("shape/martinique.shp", package="cartography"))
# display this POLYGON layer
plot(st_geometry(mtq), col = 1:8)