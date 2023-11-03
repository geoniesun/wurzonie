#with this code you can download geodata like precipitation for different countries 
# or continents


#to activate the packages you must do the library command
library(terra)
library(sf)
library(geodata)
library(rnaturalearth)

ger <- ne_countries(continent = "south america", scale = "medium", returnclass = "sf") #get country borders
#plot(ger)
#ger is vector

#using :: makes sure to use the right package
#get temperature data
clim <- geodata::worldclim_global(var="tmin", res=10, download = T, path = ".") 
#clim is raster dataset
#plot(clim)

ger.r <- st_transform(ger, st_crs(clim)) #change crs to T one
#plot(ger.r)

clim_ger_crop <- terra::crop(clim, ger.r) #crop precipitation to extent of germany which is always a square
#plot(clim_ger_crop) 

clim_ger_mask <- terra::mask(clim_ger_crop, ger.r) #mask precipitation to shape of germany
plot(clim_ger_mask)


#do everything again but better now
climGer_vect <- terra::extract(clim_ger_mask, ger, mean) #extract precipitation average of germany, other statistics possible as well
climGer_vect
#plot(unlist(climGer_vect[,2:13]))




