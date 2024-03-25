# LANDSAT PREPROCESSING
#https://www.usgs.gov/landsat-missions/using-usgs-landsat-level-1-data-product
library(terra)
library(mapview)
source("C:/eagle/wurzonie/tutorium/day9_estimateHaze.R")

ls_dir <- paste0("C:/eagle/wurzonie/tutorium/data/LT05_L1TP_194026_20111015_20200820_02_T1/")

# pre-processing
ls_files <- list.files(path = ls_dir, full.names = T)

# get our meta data
ls_files_meta <- grep(pattern = "MTL.txt", x = ls_files, value = T)

# lets read everything we need from the MTL
meta <- readLines(ls_files_meta)
meta_fields <- c(
  "RADIANCE_MULT_BAND",
  "RADIANCE_ADD_BAND",
  "REFLECTANCE_MULT_BAND",
  "REFLECTANCE_ADD_BAND",
  "SUN_ELEVATION",
  "EARTH_SUN_DISTANCE",
  "K1_CONSTANT_BAND",
  "K2_CONSTANT_BAND"
)

# extract values from MTL
meta_vals <- lapply(meta_fields, function(field){
    meta_lines <-  grep(field, meta, value = T)

 #get values 
    vals <- lapply(meta_lines, function(line){
    strsplit(line, " = ")[[1]][2]
 })
  names(vals) <- sapply(meta_lines, function(line){
  gsub(" ", "", strsplit(line, "=")[[1]][1]
 )
   return(vals)
})
 
#check
 meta_vals
 length(meta_vals)
 length(meta_vals[[8]])
 
#make it tidy
 meta_vals <- unlist(meta_vals)
 meta_arr <- attributes(meta_vals)
 meta_vals <- as.numeric(meta_vals)
 attributes(meta_vals) <- meta_arr
 
 #get hands on raster data
 ls_fiels_bands <- list.files(path = ls_dir, 
                              pattern = glob2rx("*_B*.TIF"),
                              full.names = T)
 
 ls_dn <- rast(ls_files_bands)
 #viewRGB()
 
 
 #convert to toa radiance
 lapply(1:nlyr(ls_dn), function(band){
   (meta_vals[[paste0("RADIANCE_MULT_BAND_", band)]] * ls_dn[[band]]) +
     meta_vals[[paste0("RADIANCE_ADD_BAND", band)]]
 })

