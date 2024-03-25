setwd("C:/Users/henni/Documents/Git/MB12/data")
x <- sf::st_read("ne_10m_admin_0_countries")

library(sf)

#load spatial boundaries file and the entsoe file
ctr <- st_read("ne_10m_admin_0_countries")
df <- read.csv("day2_data_energy_prod_EU_2020-08-03_2020-08-09.csv")

unique(df$MapCode)
View(ctr)

#select a column best to represent all the countries that are in the entsoe data set
unique(ctr$ISO_A2)
ctr$WB_A2

#####task 2: Aggreagte the energy dataset########
# Use mutate to create a new column 'Copy_Value' and fill it with a copy of 'Value'
#df <- df %>%
 # mutate(MapCode2 = MapCode)
#View(df)

#df$MapCode2 <- df[grep("DE_", df$MapCode2),"MapCode2"]


#task2 musterlösung
df$ctr_code <- df$MapCode

stringr::str_trunc(df$ctr_code,2 ,"right") # trims the names to the first two digits
grep("DE_", df$MapCode2)                   #  indexing every value that includes DE_....
df$MapCode2[grep("DE_", df$MapCode2)] <- "DE"    # overwrites what we indexed
grep("DE_", df$MapCode2)
#replace NIE cases with GB
df$MapCode2 <- gsub("NIE","GB", df$MapCode2)

#aggregate
df_aggr <- aggregate(
  df[,c("ActualGenerationOutput", "ActualConsumption", "InstalledGenCapacity")],
  by = list(df$ctr_code),
  FUN = sum,
  na.rm = T      # needed to cut out the NA when generating sum, otherwise outputs is NA
)

colnames(df_aggr)[1] <- "ctr_code"
#sum(c(1,2,3,4,NA),na.rm)   

#task3: checking for remaining differences
#copy the country code column to the boundaries df
ctr$MapCode2 <- df$MapCode2

#task 3
ctr$ctr_code <- ctr$WB_A2

#which country is missing in the boundaries layer
df_aggr$ctr_code[!(df_aggr$ctr_code%in% ctr$ctr_code)]

#task fo next time: assign "NO" for the missing case in 
#ctr$ctr_code
ctr$ctr_code[grep("Norway", ctr$NAME_EN)] <- "No"

#check
df_aggr$ctr_code[!(df_aggr$ctr_code%in% ctr$ctr_code)]

# save oth our Entsoe-E aggregated dataset and the 
# cleaned countries dataset to disk
class(df)
write.csv(df_aggr, "energy_aggr_ctr_2020.csv")
class(ctr)
st_write(ctr, "ne_10m_admin_0_countries.gpkg", append = FALSE)



