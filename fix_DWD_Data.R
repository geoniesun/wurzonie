###########
# download and display temperature and precipitation for Germany
# created just for teaching purpose - not for scientific analysis! 100% accuracy not ensured
# learning goal: download data, convert them, analyse spatio-temporal data and display them
# ###########
# 
# idea triggered by these news articles:
# https://projekte.sueddeutsche.de/artikel/wissen/bilanz-des-sommers-und-der-hitzewelle-2018-e547928/
# https://projekte.sueddeutsche.de/artikel/panorama/duerre-in-deutschland-e407144/
# https://www.nytimes.com/interactive/2018/08/30/climate/how-much-hotter-is-your-hometown.html
# 
# idea to replicate the news infos by using the weather data of the german weather service
# 
# Sept./Oct. 2018, written, adapted, modified and commented by 
# Marius Philipp (EAGLE MSc. student, student assistant Aug/Sept. 2018) and Martin Wegmann
# 
# to-do and ideas:
# make it more generic to select years, months and datasets
# loop through months and download all
# analyse trend and map it
# create animations w/ gganimate and tweenr of time series (maps and line plot), mean temp map and transition to year x map
# adapt some ideas from this weather in Japan R script: https://ryo-n7.github.io/2018-10-04-visualize-weather-in-japan/

################################
### Download from ftp server ###
################################
#load data
# activate library to fetch url infos
library(RCurl)
#activate tidyverse for load in data
library(tidyverse)
# activate relevant raster packages
library(sf)
library(terra)
library(dplyr)
# to unzip the ascii files
library(R.utils)
# to calculate min and max value
library(gridExtra)
#facet wrap (to plot next to each other)
#library(tidyterra)
#activate ggplot2 to plot results
library(ggplot2)
# to plot raster data in ggplot2
library(stars)
# read ascii files

# Define http and use the getURL from the RCurl package to list the data
# In this example I chose the monthly mean temperature, but it can be switched to e.g. precipitation etc.
# All that needs to be done is change the link to the desired data files
#http <- "ftp://ftp-cdc.dwd.de/pub/CDC/grids_germany/monthly/air_temperature_mean/08_Aug/"
http <- "ftp://opendata.dwd.de/climate_environment/CDC/grids_germany/monthly/air_temperature_mean/08_Aug/"
setwd("C:/Users/marle/UniWuerzburg/EAGLE/Introduction_to_programming/Git_Test4/Test/")
# Data for monthly precitpiation in August can be found on the ftp as well:
# ftp://opendata.dwd.de/climate_environment ...
# List resulting datasets of given url
result <- getURL(http, verbose=TRUE, ftp.use.epsv=TRUE, dirlistonly = TRUE)
result
# Split string into pieces by identifying certain pattern that seperates the individual filenames
result_tidy <- str_split(result, "\n|\r\n")  # sometimes \r needed
result_tidy
result_tidy <- result_tidy[[1]] # davor sind alle Einträge in [[1]] gespeichert, wir wollen aber eine gscheite Liste
result_tidy
# Reorder data frame to alphabetically decreasing file names
result_tidy <- sort(result_tidy, decreasing = F) # letzter Eintrag davor ist leer, deswegen sortieren und dann ersten EIntrag löschen
result_tidy
# Delete first entry which is empty because of the previously applied pattern
result_tidy <- result_tidy[2:length(result_tidy)]
result_tidy
# Data can already be subsetted to desired years e.g. 1961-2023
first_year <- result_tidy[1]

# 1: 1881
# 80: 1980
# 143: 2023
# um nur bestimmte Jahre zu adressen 
#result_tidy <- result_tidy[c(seq(1,140, by=1))]
#result_tidy

# Define output directory of downloads
# create one if not yet there, warning if it exists
dir.create("DWDdata/")
out_dir <- "DWDdata/"

# loop for downloading all files listed in the ftp-server if they do not yet exist in the folder
for (i in 1:length(result_tidy)) {
  if(file.exists(paste0(out_dir, result_tidy[i]))){
    print(paste0(result_tidy[i], sep=" ", "file already exists"))
  }
  else
  {
    download.file(paste0(http, result_tidy[i]), paste0(out_dir, result_tidy[i]))
  }
}

############################
### Read ASCII-Grid-File ###
############################

# ## Define file names and directory
mypath <- "DWDdata/"

# just grep all "temp" (= temperature) file, instead of "precipitation"
# check the names in the folder which pattern is appropriate
temp <- grep(".*temp.*", list.files(path = mypath, pattern="*.gz$"), value=T)

filenames <- paste0(mypath, temp)
# read all ascii files and convert them into a raster stack
for (i in 1:length(filenames)){
  if (i == 1){
    # remove the raster in case it already exists to avoid duplicate entries
    rm(my_raster)
    unzip_file <- gunzip(filenames[i], remove = FALSE, overwrite = TRUE)
    my_raster <- rast(unzip_file)
  } else {
    # ... and fill it with each additional run with another layer
    unzip_file <- gunzip(filenames[i], remove = FALSE, overwrite = TRUE)
    current_raster <- rast(unzip_file)
    add(my_raster) <- current_raster
    # Delete all variables except for the raster stack "my_raster"
    rm(i, current_raster)
  }
}
?terra # to get information for differences in raster and terra
# optional to check the structure
my_raster

# Change names of raster layers
# adapt sequence in case you subsetted the data before
layer_names <- c(paste0("Year_", seq(1881, 2023, by=1)))
names(my_raster) <- layer_names
plot(my_raster$Year_1881)
# Subset Raster-Stack into old dates and new date
# select range of historical data to subset
# time-series data, to use for temporal aggregation
# define the first and last year to grab from the time series 
rasterHist <- my_raster[[grep("1961", layer_names):grep("1991", layer_names)]]
# year for comparison to long term statistics
rasterComp <- my_raster$Year_2013

# Add Coordinate Reference System to rasterstack
# information extracted from DWD webpage
# ftp://ftp-cdc.dwd.de/pub/CDC/grids_germany/monthly/air_temperature_mean/DESCRIPTION_gridsgermany_monthly_air_temperature_mean_en.pdf
my_crs <- "+init=epsg:31467"

crs(rasterHist) <- my_crs
crs(rasterComp) <- my_crs
rasterHist
# for temperature only!
# do NOT use for precipitation or other datasets
# Divide by 10 to get values in C as described in the description pdf on the ftp server:
# ftp://ftp-cdc.dwd.de/pub/CDC/grids_germany/monthly/air_temperature_mean/
# DESCRIPTION_gridsgermany_monthly_air_temperature_mean_en.pdf
rasterHist <- rasterHist/10
rasterComp <- rasterComp/10

# Calculate mean temperature between 1961 and 1990
rasterHist_mean <- mean(rasterHist)
maxVal <- max(c(unique(values(rasterComp)),unique(values(rasterHist_mean))),na.rm=T)
minVal <- min(c(unique(values(rasterComp)),unique(values(rasterHist_mean))),na.rm=T)


p1 <- ggplot() +
  geom_stars(data=rasterHist_mean %>% st_as_stars())+
  scale_fill_gradient2(low="blue", mid='yellow', high="red", name ="temperature", na.value = NA, limits=c(minVal,maxVal))+
  # , guide = F
  labs(x="",y="")+
  ggtitle("Mean Temperatures August 1961-1991")+
  theme(plot.title = element_text(hjust = 0.5, face="bold", size=15))+
  theme(legend.title = element_text(size = 12, face = "bold"))+
  theme(legend.text = element_text(size = 10))+
  theme(axis.text.y = element_text(angle=90))+
  scale_y_continuous(breaks = seq(5400000,6000000,200000))+
  xlab("")+
  ylab("")
p1

p2 <- ggplot() +
  geom_stars(data=rasterComp %>% st_as_stars())+
  scale_fill_gradient2(low="blue", mid='yellow', high="red", name ="temperature", na.value = NA, limits=c(minVal,maxVal))+
  labs(x="",y="")+
  ggtitle("Temperature August 2018")+
  theme(plot.title = element_text(hjust = 0.5, face="bold", size=15))+
  theme(legend.title = element_text(size = 12, face = "bold"))+
  theme(legend.text = element_text(size = 10))+
  theme(axis.text.y = element_text(angle=90))+
  scale_y_continuous(breaks = seq(5400000,6000000,200000))+
  xlab("")+
  ylab("")
p2
pdf("August_mean_vs_2018.pdf", width = 14, height = 8)
grid.arrange(p1, p2, ncol=2)
dev.off()

# side-by-side plots, same height, just one legend
df <- as.data.frame(rasterHist_mean, xy = TRUE)
View(df)
df2 <- as.data.frame(rasterComp, xy = TRUE)
View(df2)
colnames(df)[3] <- colnames(df2)[3] <- "values"
?tidyterra

dfab <- rbind(data.frame(df,band="1961-1990 (mean)"), data.frame(df2,band="2018"))
View(dfab)
pdf("August_mean_vs_2018_2.pdf", width = 12, height = 8)

p3 <- ggplot(dfab, aes(x,y,fill=values))+geom_raster()+facet_grid(.~band)+
    scale_fill_gradient2(low="blue", mid='yellow', high="red", name ="temperature", na.value = NA, limits=c(minVal,maxVal))+
    labs(x="",y="")+
    ggtitle("Differences in Temperatures: August")+
    theme(plot.title = element_text(hjust = 0.5, face="bold", size=15))+
    theme(legend.title = element_text(size = 12, face = "bold"))+
    theme(legend.text = element_text(size = 10))+
    theme(axis.text.y = element_text(angle=90))+
    scale_y_continuous(breaks = seq(5400000,6000000,200000))+
    xlab("")+
    ylab("")+
    coord_equal()
p3
dev.off()

# compute difference of historical and raster to compare with
raster_diff <- rasterComp - rasterHist_mean

# Create Difference Map
p4 <- ggplot()+
  geom_stars(data=raster_diff %>% st_as_stars())+
  scale_fill_gradient2(low="blue", mid='yellow', high="red", name ="temp. diff.", na.value = NA)+
  labs(x="",y="")+
  ggtitle("Temperature Differences")+
  theme(plot.title = element_text(hjust = 0.5, face="bold", size=15))+
  theme(legend.title = element_text(size = 12, face = "bold"))+
  theme(legend.text = element_text(size = 10))+
  theme(axis.text.y = element_text(angle=90))+
  scale_y_continuous(breaks = seq(5400000,6000000,200000))+
  xlab("")+
  ylab("")
p4

pdf("August_mean_vs_2018_vs_diff.pdf", width = 20, height = 8)
grid.arrange(p1, p2, p3, ncol=3)
dev.off()


#################################
### Create a time Series plot ###
#################################

# Add Coordinate Reference System to raster stack
crs(my_raster) <- my_crs
# Divide raster by 10 to get °C values
my_raster <- my_raster/10
my_raster
# Define dataframe and fill it with the dates
my_years <- c(seq(1881, 2023, by=1))
my_mat <- matrix(data = NA, nrow = length(my_years), ncol = 2)
my_mat[,1] <- my_years
my_df <- data.frame(my_mat)
names(my_df) <- c("Year", "Mean_Temp")
my_df
# For-loop calculating mean of each raster and save it in data.frame
for (i in 1:length(my_years)){
  current_layer <- my_raster[[i]]
  current_mean <- mean(values(current_layer), na.rm=TRUE)
  my_df[i, 2] <- current_mean
  rm(current_layer, current_mean, i)
}
names(my_df) <- c("Year", "Mean_Temp")

#check df
str(my_df)

# Plot resulting dataframe and perform a regression analysis to display a trend line
pdf("timeseries_mean_temp.pdf",width=15,height=8)
p4 <- ggplot(my_df, aes(x=Year, y=Mean_Temp))+
    geom_point(size=2)+
    geom_line()+
    geom_smooth(method="loess", se=TRUE, formula= y ~ x)+
    labs(title="Time Series of Mean Temperature Across Germany in August", 
        x="Year", y="Mean Temperature in C") +
    theme(plot.title = element_text(hjust = 0.5))
print(p4)
dev.off()

# #########
# split by region and see what the differences are
# #########
first_raster <- (my_raster[[1]])
crs(first_raster) <- my_crs

# Optional: Reproject the raster to latlon
first_raster <- project(first_raster, "+proj=longlat")
pdf("my_raster_1.pdf",width=8,height=7.5)
# Create a ggplot
p5 <- ggplot() +
      geom_stars(data=first_raster %>% st_as_stars())+
      scale_fill_gradient2(low="blue", mid='yellow', high="red", name ="temperature", na.value = NA, limits=c(minVal,maxVal))+
      # , guide = F
      labs(x="",y="")+
      ggtitle("Mean Temperatures August 1961-1991")+
      theme(plot.title = element_text(hjust = 0.5, face="bold", size=15))+
      theme(legend.title = element_text(size = 12, face = "bold"))+
      theme(legend.text = element_text(size = 10))+
      theme(axis.text.y = element_text(angle=90))+
  # for coordinates in m
  # scale_y_continuous(breaks = seq(5400000,6000000,200000))
  # Optional: for coordinates in latlon
  # scale_x_continuous(limits=c(5, 16), breaks=seq(6, 14, 2), labels=c("6°", "8°", "10°", "12°", "14°"))+
  # scale_y_continuous(limits=c(47, 55), breaks=seq(48, 54, 2), labels=c("48°", "50°", "52°", "54°"))+
      xlab("")+
      ylab("")
p5
dev.off()

# Download administrative boundaries data
library(geodata)
bnd <- gadm(country="GERMANY", path=tempdir())
pdf("Germany.pdf",width=8,height=7.5)
plot(bnd)
dev.off()

bnd <- project(bnd, crs(my_raster))

# visual check
pdf("Germany.pdf",width=8,height=7.5)
plot(bnd)
dev.off()

#Only bavaria
bnd.by <- bnd[bnd$NAME_1=="Bayern",]

# visual check
pdf("Bayern_Ger.pdf",width=9,height=15)
plot(my_raster,1)
plot(bnd.by)
dev.off()

# crop and mask the data
my_raster.by <- crop(my_raster, bnd.by)
my_raster.by <- mask(my_raster.by, bnd.by)

# visual check
plot(my_raster.by,1)

# For-loop calculating mean of each raster and save it in data.frame
for (i in 1:length(my_years)){
  current_layer <- my_raster.by[[i]]
  current_mean <- mean(terra::values(current_layer), na.rm=T)
  my_df[i,2] <- current_mean/10
  rm(current_layer, current_mean, i)
}

# check data frame structure/content
my_df

# Plot resulting dataframe and perform a regression analysis to display a trend line
pdf("timeseries_mean_temp_BY.pdf",width=15,height=8)
ggplot(my_df, aes(x=Year, y=Mean_Temp))+
  geom_point(size=2)+
  geom_line()+
  geom_smooth(method="loess", se=TRUE, formula= y ~ x)+
  labs(title="Time Series of Mean Temperature Across Bavaria in August", 
       x="Year", y="Mean Temperature in ?C") +
  theme(plot.title = element_text(hjust = 0.5))
dev.off()
