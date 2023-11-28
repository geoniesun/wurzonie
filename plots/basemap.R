if(!require("osmdata")) install.packages("osmdata")
if(!require("tidyverse")) install.packages("tidyverse")
if(!require("sf")) install.packages("sf")
if(!require("ggmap")) install.packages("basemap")

#load packages
library(tidyverse)
library(osmdata)
library(sf)
library(ggmap)
library(RCurl)
library(ggplot2)
library(sf)
library(basemaps)

df <- read.csv("https://raw.githubusercontent.com/wegmann/R_data/master/Steigerwald_sample_points_all_data_subset_withNames.csv", header = TRUE)

df
df.sf <- st_as_sf(x = df,
                  coords = c("x", "y"),
                  crs = 'epsg:32632'
) #32632

data(world_imagery)
get_maptypes()
