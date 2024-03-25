library(stars)
library(dplyr)
#tif = "E:/Eagle/courses/introprogramming/data/S2_ALL_10m-20m_T32UPA_20180507_UTM_WGS84_32N_AOI.tif"
tif = system.file("tif/L7_ETMs.tif", package = "stars")
read_stars(tif) |>
  slice(index = 1, along = "band") |>
  plot()
