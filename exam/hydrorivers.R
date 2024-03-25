#https://blog.benthies.de/blog/mapping-streams-and-rivers-with-ggplot-sf/
#https://www.hydrosheds.org/products/hydrorivers
#https://milospopovic.net/map-rivers-with-sf-and-ggplot2-in-r/

# Load libraries
library(dplyr) # Data manipulation
library(ggplot2) # Plotting
library(rnaturalearth) # To load the SA shapefile
library(rnaturalearthdata) # "-"
library(sf) # Geometric operations
library(stringr) # String operations

setwd("E:/Eagle/courses/introprogramming/exam/")
# Load river and world data

rivers <- st_read("rawdata/HydroRIVERS_v10_sa_shp/HydroRIVERS_v10_sa_shp/HydroRIVERS_v10_sa.shp")

# Load and manipulate maps
world <- ne_countries(scale = "medium", returnclass = "sf")
plot(world$geometry)

colombia <- ne_countries(country = "colombia", returnclass = "sf")
ggplot() + geom_sf(data=colombia)
colombia_box <- st_bbox(colombia)
colombia_box
#xmin       ymin       xmax       ymax 
#-78.990935  -4.298187 -66.876326  12.437303 


plot(colombia$geometry)
# xmin      ymin      xmax      ymax 
# -17.62504 -34.81917 51.13387  37.34999 



# Filter river data to only contain streams in Africa / Arabia
rivers_colombia <- st_crop(rivers, colombia)
saveRDS(rivers_colombia, "processeddata/rivers_colombia.rds") # Save object for later easy + fast reuse