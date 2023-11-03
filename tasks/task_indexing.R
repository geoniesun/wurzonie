df_1 <- data.frame(plot="location_name_1", measure1=runif(100)*1000,measure2=round(runif(100)*100),
                   value=rnorm(100,2,1),ID=rep(LETTERS,100)[1:100])

df_2 <- data.frame(plot="location_name_2", measure1=runif(50)*100,measure2=round(runif(50)*10),
                   value=rnorm(50),ID=rep(LETTERS,50)[1:50])

df <- rbind(df_1,df_2)
df
df_1

#plot data frame but just for plot and measure 1 and 2
df[,c('plot', 'measure1', 'measure2')]

#plot df just for line 66 to 70 and plot m1 and m2
df[66:70,c('plot', 'measure1', 'measure2')]


#task1
#plot just two variables measure 1 and measure 2
df[,c('measure1', 'measure2')]

#task2:
#plot just certain values in measure 1
df[55:66,c('plot','measure1')]

#task3: plot three variables
install.packages("ggplot2")
library(ggplot2)
ggplot(df, aes(x = value, y = measure1, color = ID)) + geom_point()



#task4:
#extract value of july 7 from precipitation data
#to activate the packages you must do the library command
library(terra)
library(sf)
library(geodata)
library(rnaturalearth)

ger <- ne_countries(country = "germany", scale = "medium", returnclass = "sf") #get country borders
#plot(ger)
#ger is vector

#using :: makes sure to use the right package
#get temperature data
prec <- geodata::worldclim_global(var="prec", res=10, download = T, path = ".") 
#clim is raster dataset
plot(prec)

ger.r <- st_transform(ger, st_crs(prec)) #change crs to T one
#plot(ger.r)

prec_ger_crop <- terra::crop(prec, ger.r) #crop precipitation to extent of germany which is always a square
#plot(clim_ger_crop) 

prec_ger_mask <- terra::mask(prec_ger_crop, ger.r) #mask precipitation to shape of germany
plot(prec_ger_mask)



plot(prec_ger_mask["wc2.1_10m_prec_07"])
prec_ger_mask["wc2.1_10m_prec_07"]

#list of average prec of germany

prec_mean <- c(1:12)
prec_ger_mask[8,9]





