#to use functions you need to add the following line at the top of the other script
#source("C:/eagle/wurzonie/collections/function_collection/veg_index.R")


NDWI_L8 <- function(gr, swir1){(gr-swir1)/(green+swir1)}

NDVI <- function(red, nir){(red-nir)/(red+nir)}   