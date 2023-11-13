#https://rpubs.com/jorgelizarazo/875858


# Load the gfcanalysis package
install.packages("raster")
install.packages("parallel")
install.packages("Rtools43")

library(gfcanalysis)
library(sf)
library(raster)
library(tidyverse)
data.folder <- 'E:/Eagle/courses/Digital Image Analysis/HANSENforest/newtrylayers'

serrascanvas <- read_sf("E:/Eagle/courses/Digital Image Analysis/HANSENforest/canvas.shp")
st <- "+proj=longlat +datum=WGS84 +no_defs"

serrascanvas <- st_transform(serrascanvas, crs = st)


install.packages("mapview")
library(mapview)
mapview(serrascanvas, layer = "Admin. level 0", color = "#000000")

# folder within were you want to download all the Hansen layers
output.folder <- "E:/Eagle/courses/Digital Image Analysis/HANSENforest/newtrylayers"

tiles <- calc_gfc_tiles(serrascanvas) #it is a funtion that provide us with the tiles amount needed to our area

plot(tiles, col = "#EF2929", lwd = 1, main = "Plot Area + Tiles", xlab = "Long", ylab = "Lat") ## please input 1 or 2 depends on the features result - it is the number of tiles needed
plot(serrascanvas,  col = "#555753", add = TRUE)
box()

#downloading from here does not work maybe if you do everything at once!
download_tiles(tiles, output.folder, images = c("lossyear", "gain", "datamask"), dataset = "GFC-2022-v1.10")
setwd('E:/Eagle/courses/Digital Image Analysis/HANSENforest/newtrylayers')
# now we extract the dataset we just downloaded
gfc <- extract_gfc(
  aoi = serrascanvas,
  data_folder = output.folder,
  dataset = "GFC-2022-v1.10",
  filename = "serras-extract.tif",
  overwrite = TRUE
)

raster1 <- raster('E:/Eagle/courses/Digital Image Analysis/HANSENforest/newtrylayers/Hansen_GFC-2022-v1.10_gain_00N_010E.tif')
plot(raster1)
