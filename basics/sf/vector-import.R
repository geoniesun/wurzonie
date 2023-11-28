#vector import with sf

library(sf)

vector_file <- st_read("path/to/file")
st_write(vector_file, "output_file_name")

#raw csv file
df <- read.csv("path/to/file.csv", header=T, sep="\t")
coordinates(df) <- c("decimallongitude", "decimallatitude") #eastings before northings

#addressing certain parts 
vector_file@data #point to data of spatial vector data set
vector_file@data$column_name # point to a specific column

vector_query <- vector_file[vector_file$column_name >54,]