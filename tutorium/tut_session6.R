library(sf)
library(ggplot2)
library(terra)


getwd()
setwd("C:/eagle/wurzonie/tutorium")
df_aggr <- read.csv("energy_aggr_ctr_2020.csv")
ctr <- st_read("ne_10m_admin_0_countries.gpkg")

box <- st_bbox(c(xmin = -30, xmax = 33, ymin = 30, ymax = 81), 
               crs = st_crs(4326))

# join these two by country code
ctr_df <- merge(ctr, df_aggr, by = "ctr_code") %>% #by is defining by which we want to join the objects
  st_crop(box) %>% 
  st_transform(st_crs(3035))  #reprojects the coordinate system
  
plot(ctr_df[,1])

View(ctr)

# task: Find a DEM that we can use for our plot and download it 
# - SRTM
# - Natural earth

#this was from henning and did not work #rnaturalearth::ne_download(scale = 50, category = 'physical', type = "MSR_50", destdir = getwd() )
#this worked
rst <- rnaturalearth::ne_download(scale = 50, type = "MSR_50M", category = "raster", destdir = getwd())

##from henning
##rsr <- rast("SR_50M/SR_50m.tif") %>% 
##  crop(box) %>% 
##  project("epsg:3035")

#now again for me
rsr <- rast("MSR_50M/MSR_50M.tif") %>%
  crop(box) %>%
  project("epsg:3035")


plot(rsr)

## convert terra object to data frame  
rst_df <- cbind.data.frame(
  crds(rsr, na.rm = F),
  values(rsr)
)
colnames(rst_df) <- c("x", "y", "value")


ggplot() + geom_raster(data = rst_df, aes(x = x, y = y, alpha = value)) +
  scale_alpha(range = c(1,0), na.value = 0)

# alternative 
#install.packages("stars")
library(stars)
#install.packages("ggnewscale")
library(ggnewscale)
ggplot() + geom_stars (data = st_as_stars(rsr)) +
  ggnewscale::new_scale_fill()

