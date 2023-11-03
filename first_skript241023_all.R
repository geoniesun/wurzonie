5+6
5*5^6-88*2


result1 <- 5+6 #better to use <- instead of = because then it is directed assigned
result1
#<- #created by using Alt and -

max() #hit F1 then you get help

 #just to learn a bit examples
seq()
seq(1,9,by=2)
seq(100)
c()
c("A", 1:100)
x <- c("A", 1:100)
plot(seq(100))
x
x

#the c() command combined values
temp_min <- c(-2,-2,0,3,7,10,12,12,8,5,1,-1)
plot(temp_min,
pch=19,
cex=2,
col="#00ff0060")

lines(lowess(temp_min,f=.2))

#installing packages
install.packages("terra","sf","geodata","rnaturalearth")
#to activate the packages you must do the library command
library(terra)
library(sf)
library(geodata)
library(rnaturalearth)
        
ger <- ne_countries(country = "Germany", scale = "medium", returnclass = "sf") #get country borders
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
#plot(clim_ger_mask)

#do everything again but better now
climGer_vect <- terra::extract(clim_ger_mask, ger, mean) #extract precipitation average of germany, other statistics possible as well
climGer_vect
#plot(unlist(climGer_vect[,2:13]))

#try out myself stuff
ger <- ne_countries(country = "Germany", scale = "medium", returnclass = "sf") #get country borders
#plot(ger)

popul_ger <- geodata::population(2020, res=10, path=tempdir())
#plot(popul_ger)

ger.r <- st_transform(ger, st_crs(popul_ger))
#plot(ger.r)


pop_crop <- terra::crop(popul_ger, ger.r)
pop_mask <- terra::mask(pop_crop, ger.r)

pop_clip <- terra::crop(popul_ger, ger.r)
#plot(pop_clip)

pop_mask <- terra:mask(pop_clip)
#plot(pop_mask)


#doesnt work it was just a try
pop_extract <- terra::extract(pop_mask, ger)
plot(pop_extract)
ls()
