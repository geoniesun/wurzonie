# session 5 - spatial data in R
# sf (vector), terra (raster)
# deprecated: sp (vector), raster (raster)
# stars
library(sf)
library(ggplot2)
library(dplyr)
library(stringr)

df <- read.csv('data/day2_data_energy_prod_EU_2020-08-03_2020-08-09.csv')
# clean outliers
df <- df[df$ActualGenerationOutput<df$InstalledGenCapacity*4,]

ctr <- st_read('data/ne_10m_admin_0_countries/ne_10m_admin_0_countries.shp')

unique(df$MapCode)
ctr$WB_A2

df$MapCodeCopy <- df$MapCode

# clean data
df$MapCodeCopy <- gsub('NIE', 'GB', df$MapCodeCopy)
df$MapCodeCopy <- str_trunc(df$MapCodeCopy, 2, 'right', ellipsis = "")
# df$MapCodeCopy[grep('DE_', df$MapCodeCopy)] <- 'DE'

# aggregate over Map Code and ActualGenerationOutput
df_aggregate_MC <- aggregate(
  df[,c('ActualGenerationOutput', 'ActualConsumption', 'InstalledGenCapacity')],
  by=list(df$MapCodeCopy),
  FUN=sum,
  na.rm=T
)
colnames(df_aggregate_MC) <- c('MapCodeCopy', 'ActualGenerationOutput_sum', 'ActualConsumption', 'InstalledGenCapacity')

# find country codes that are in energy dataset but not in country dataset
ctr$MapCodeCopy <- ctr$WB_A2
df_aggregate_MC$MapCodeCopy[!(df_aggregate_MC$MapCodeCopy %in% ctr$MapCodeCopy)]

# Assign NO for the missing case in ctr$MapCodeCopy
ctr$MapCodeCopy[grep('Norway', ctr$NAME_EN)] <- 'NO'

# save the dataframes
class(df_aggregate_MC)
class(ctr)
st_write(ctr, 'data/ne_10m_admin_0_countries/admin_ctr_cleared.gpkg', append=F)
# write.csv(df_aggregate_MC, 'data/energy_aggr_ctr_2020.csv')
