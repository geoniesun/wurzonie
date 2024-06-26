#add this to the code of last week

df <- read.csv("C:/eagle/wurzonie/day2_data_energy_prod_EU_2020-08-03_2020-08-09.csv")

# explore: column names
names(df)
# first rows
head(df)

# number of countries or energy grids
length(unique(df$MapCode)) # clean countries
# number of records
dim(df)
nrow(df)
# what type/strucutre/class is this?
class(df$DateTime) # make this sortable (= not character)
# transform into POSIXct
df$DateTimePOS <- as.POSIXct(df$DateTime)

# let's make a first plot: scatter generated energy against installed capacity
plot(
  x = df$InstalledGenCapacity,
  y = df$ActualGenerationOutput
)

# we see that we have some outliers, so lets introduce a filter based on this assumption:
# generated energy cannot be very much higher than installed capacity (maybe only a bit due
# to reading errors or something like that)
# so: keep only those records of which the generated energy is smaller then the installed capacity times 4
nrwos_df_not_cleand <- nrow(df)
df <- df[df$ActualGenerationOutput < df$InstalledGenCapacity*4,]
nrow(df)

# run the plot again
plot(
  x = df$InstalledGenCapacity,
  y = df$ActualGenerationOutput
)
# we still see some outlieres and we already see how the data is distributed

# TASK: Create plots using plot and ggplot syntax. Find out more information
# about our dataset!
# for example: 
# - plot the number of power plants per production type, or
# - production capacity per type



###end of this session

##session frrom 14.11.23
# plot 1: number of records per production type
plants <- df[,c("GenerationUnitEIC", "ProductionTypeName")]
counts <- table(plants$ProductionTypeName)

barplot(counts, horiz = T)
barplot(sort(counts), horiz = T, las = 2,
        col = rainbow(length(counts)))

# create graphics device for saving
dev.off()
png("entsoe_prdtype_units.png", width = 700, height = 700)
par(mar = c(4, 11, 4, 4))
barplot(sort(counts), horiz = T, las = 1,
        col = rainbow(length(counts)))
title(main = "Number of records per production type\nacross te EU, 1st week of Aug. 2020",
      xlab = "Number of records")
dev.off()

# plot 2: production capacity per type
# production capacity per type
# first, we need to aggregate installed capacity by production type using sum(),
# so that we get the overall capacity for the whole week per production type
df_agg_type <- aggregate(
  df$InstalledGenCapacity,
  by = list(df$ProductionTypeName),
  FUN = sum
)
head(df_agg_type)

# we can rename the columns with more expressive names
colnames(df_agg_type) <- c(
  "ProductionTypeName",
  "InstalledGenCapacity_sum"
)
# lets convert the capacity values from Megawatt to Gigawatt
df_agg_type$InstalledGenCapacity_sum <- df_agg_type$InstalledGenCapacity_sum * 0.001
# lastly, we order everything by capacity, from small to high
df_agg_type <- df_agg_type[order(df_agg_type$InstalledGenCapacity_sum),]
df_agg_type$ProductionTypeName <- factor(df_agg_type$ProductionTypeName,
                                         levels=unique(df_agg_type$ProductionTypeName))

# plotting this as barplot in ggplot2
library(ggplot2)
library(dplyr)


ggplot() +
  geom_bar(data = df_agg_type, 
           aes(x = InstalledGenCapacity_sum,
               y = ProductionTypeName,
               fill = ProductionTypeName, ),
           stat = "identity", show.legend = F) +
  labs(title = "Installed production capacity by production type across the EU, 1st week of August 2020",
       subtitle = "Source: ENTSO-E Transparency Report 2020",
       x = "Installed Capacity [GW]",
       y = "Prodution Type") +
  scale_x_continuous(expand = c(0,0)) +
  theme(plot.title = element_text(face = "bold")) +
  theme_minimal()

# TASK: how can we change the order of the types (hint: factors and levels)?
