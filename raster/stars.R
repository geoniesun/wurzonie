tif <- "E:/Eagle/courses/introprogramming/data/S2_ALL_10m-20m_T32UPA_20180507_UTM_WGS84_32N_AOI.tif"

install.packages("stars")
library(stars)

importRater <-  read_stars(tif)

write_stars(rasterObj["NDVI" ,,,], tif)
