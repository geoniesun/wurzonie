library(sf)
#install.packages("rinat")
library(rinat) # for downloading occurence data
library(dplyr)
library(rnaturalearth)


## Load the conflicted package and set preferences
library(conflicted)
conflict_prefer("filter", "dplyr", quiet = TRUE)
conflict_prefer("count", "dplyr", quiet = TRUE)
conflict_prefer("select", "dplyr", quiet = TRUE)
conflict_prefer("arrange", "dplyr", quiet = TRUE)


# get country boundaries
mn <- st_read("C:/Users/Leonie Sonntag/Documents/Leonie/Studium/eagle/tobecopiedtousb/modelling/data/natural-earth-countries-1_110m/natural-earth-countries-1_110m.shp")
mn <- st_transform(mn, crs=4326)
mn <- mn %>%  dplyr::select(geometry, name)

# Download data with geodata's world function to use for our base map
world_map <- geodata::world(resolution = 3,
                   path = "data/")

# Crop the map to our area of interest
my_map <- crop(x = world_map, y = mn_bb)


# bounding box
mn_bb <- mn %>%
  st_bbox()

#make bbox a polygon
bbox_sf <- st_polygon(list(rbind(
  c(mn_bb["xmin"], mn_bb["ymin"]),
  c(mn_bb["xmin"], mn_bb["ymax"]),
  c(mn_bb["xmax"], mn_bb["ymax"]),
  c(mn_bb["xmax"], mn_bb["ymin"]),
  c(mn_bb["xmin"], mn_bb["ymin"])
)))

plot(bbox_sf, axes = T, col = "grey")

#get occ data by bbox
locust <- get_inat_obs(taxon_name = "Calliptamus italicus", bounds = mn_bb[c(2,1,4,3)])
locust
str(locust)

plot(my_map, axes = T, col = "grey95")
points(x = locust$x, y = locust$y,col = "olivedrab")

# Make an extent that is 25% larger
#sample_extent <- mn_bb * 1.25


#convert into sf object (not needed)
#locst_sf <- locust %>%
#  select(longitude, latitude, datetime, common_name, 
#         scientific_name, image_url, user_login) %>%
#  st_as_sf(coords=c("longitude", "latitude"), crs = 4326)

#dim(locst_sf)  # how many occ we have?
#plot(locust$longitude, locust$latitude)



#mn %>% st_set_crs(st_crs(locst_sf))
#filter by outline of country
#inat_obs_pcsp_sf <- locst_sf %>% st_intersection(mn)
#nrow(inat_obs_pcsp_sf)
#dim(inat_obs_pcsp_sf)
#plot(inat_obs_pcsp_sf)

# now getting to flexsdm
devtools::install_github('sjevelazco/flexsdm')
library(flexsdm)

#get env data
library(geodata)
tmin <- worldclim_country("Montenegro", var = "tmin", path = "C:/Users/Leonie Sonntag/Documents/Leonie/Studium/eagle/tobecopiedtousb/modelling/data/worldclimdata")
tmax <- worldclim_country("Montenegro", var = "tmax", path = "C:/Users/Leonie Sonntag/Documents/Leonie/Studium/eagle/tobecopiedtousb/modelling/data/worldclimdata")
prec <- worldclim_country("Montenegro", var = "prec", path = "C:/Users/Leonie Sonntag/Documents/Leonie/Studium/eagle/tobecopiedtousb/modelling/data/worldclimdata")

tmin <- rast("C:/Users/Leonie Sonntag/Documents/Leonie/Studium/eagle/tobecopiedtousb/modelling/data/worldclimdata/wc2.1_country/MNE_wc2.1_30s_tmin.tif")
tmax <- rast("C:/Users/Leonie Sonntag/Documents/Leonie/Studium/eagle/tobecopiedtousb/modelling/data/worldclimdata/wc2.1_country/MNE_wc2.1_30s_tmax.tif")
prec <- rast("C:/Users/Leonie Sonntag/Documents/Leonie/Studium/eagle/tobecopiedtousb/modelling/data/worldclimdata/wc2.1_country/MNE_wc2.1_30s_prec.tif")

# Crop bioclim data to desired extent



prec_sel <-subset(prec, 2:5)
names(prec_sel) <- c("a", "b", "c", "d" )




library(terra)

env_stack <- c(tmin, tmax, prec)
plot(env_stack[[2]]) #just to see
plot(env_stack)

crs(env_stack) <- "epsg:4326"
mn_terra <- vect(mn)
#locust_bbox <- st_as_sfc(st_bbox(locst_sf), crs = env_stack)
#locust_bb_terra <- vect(locust_bbox)


locust <- locust %>% select(longitude, latitude)
locust <- locust %>% rename( y = latitude, x = longitude) 
locust_ext <- extract(prec_sel, locust)

locust_df_new <- data.frame(locust, locust_ext)
locust_ext_NA <- na.omit(locust_df_new)
locust_ext_NA <- locust_ext_NA %>% select(x,y)

#start the modelling



ca <- calib_area(
  data = locust_ext_NA,
  x = "x",
  y = "y",
  method = c('buffer', width =25000),
  crs = crs(prec_sel)
)

# Sample the same number of species presences
set.seed(10)
psa <- sample_pseudoabs(
  data = locust_ext_NA,
  x = "x",
  y = "y",
  n = nrow(locust_ext_NA), # selecting number of pseudo-absence points that is equal to number of presences
  method = "random",
  rlayer = prec_sel,
  calibarea = ca
)

# Bind a presences and pseudo-absences
locust_pa <- bind_rows(locust_ext_NA, psa)
locust_pa[is.na(locust_pa)] <- 1

set.seed(10)
plot(my_map, axes = T, col = "grey95")
points(x = locust_pa$x, y = locust_pa$y,col = "olivedrab")
points(psa,
       col = "grey30",
       pch = 1,
       cex = 0.75)

# Repeated K-fold method
locust_pa2 <- part_random(
  data = locust_pa,
  pr_ab = "pr_ab",
  method = c(method = "rep_kfold", folds = 5, replicates = 10)
)

locust_pa3 <-
  sdm_extract(
    data = locust_pa2,
    x = 'x',
    y = 'y',
    env_layer = prec_sel,
   variables = c("a", "b", "c", "d" )
  )


mglm <-
  fit_glm(
    data = locust_pa3,
    response = 'pr_ab',
    predictors = c("a", "b", "c", "d" ),
    partition = '.part',
    thr = 'max_sens_spec'
  )

mpred <- sdm_predict(
  models = mglm,
  pred = prec_sel,
  con_thr = TRUE,
  predict_area = ca
)

plot(mpred[[1]])



mgbm <- fit_gbm(
  data = locust_pa3,
  response = 'pr_ab',
  predictors = c("a", "b", "c", "d" ),
  partition = '.part',
  thr = 'max_sens_spec'
)

msvm <-  fit_svm(
  data = locust_pa3,
  response = 'pr_ab',
  predictors = c("a", "b", "c", "d" ),
  partition = '.part',
  thr = 'max_sens_spec'
)

mpred <- sdm_predict(
  models = list(mglm, mgbm, msvm),
  pred = prec_sel,
  con_thr = TRUE,
  predict_area = ca
)

par(mfrow = c(3, 2))
plot(mpred$glm, main = 'Standard GLM')

#points(hespero$x, hespero$y, pch = 19)
plot(mpred$gbm, main = 'Standard GBM')
#points(hespero$x, hespero$y, pch = 19)

#points(hespero$x, hespero$y, pch = 19)
plot(mpred$svm, main = 'Standard SVM')
#points(hespero$x, hespero$y, pch = 19)

