library(raster)
library(cluster)
library(RStoolbox)
library(terra)
library(caret)
library(rgdal)
library(sf)

r <- lsat
uc <- unsuperClass(lsat, nClasses=8)

ggR(uc$map, forceCat = TRUE, geom_raster = TRUE)



# create a temporary filename for the example
f <- file.path("E:/Eagle/courses/introprogramming", "lsat.tif")

writeRaster(r, f, overwrite=TRUE)


td <- readOGR("E:/Eagle/courses/introprogramming", "lsat_classification")

plot(td, add = TRUE)
td$class
plot(td$class[1])

sc <- superClass(r, trainData = td,
                 model = "rf",
                 responseCol = "class",
                 filename = "myClassification.tif")
?superClass
plot(sc$map)

