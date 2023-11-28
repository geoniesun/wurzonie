df <- read.csv("C:/eagle/wurzonie/day2_data_energy_prod_EU_2020-08-03_2020-08-09.csv")
head(df)
summary(df)
View(df)
dim(df)
nrow(df)

names(table(df$MapCode)) ##all countries sorted by alphabet
length(unique(df$MapCode))  ## all countries not sorted, clean countries!

typeof(df$DateTime)
class(df$DateTime) #make this sortable (=not character)
df$DateTimePOS <- as.POSIXct(df$DateTime)

#make a plot: scatter: actual output over installed capacity

plot(
  x=df$InstalledGenCapacity,
  y=df$ActualGenerationOutput
)

#get rid of outliers: remove all cases where the output is higher than the installed capacity

df <- df[df$ActualGenerationOutput<df$InstalledGenCapacity*4,]

#run plot again
plot(
  x=df$InstalledGenCapacity,
  y=df$ActualGenerationOutput
)

#plot it on a time scale
#plot for 1 powerplant, e.g. with ggplot2


plants <- df[,c("GenerationUnitEIC", "ProductionTypeName")]
counts <- table(plants$ProductionTypeName)
barplot(counts, horiz= T)
barplot(sort(counts), horiz = T, las = 1,
        col = rainbow(length(counts)))
length(counts)
plants <- unique(df$GenerationUnitEIC)




#save to png
dev.off()
png("entsoe_prdtype_units.png",width = 700,height=700)
par(mar=c(4,11,4,4))
barplot(sort(counts),horiz=T,las=1,
        col=rainbow(length(counts)))
title(main="Number of Records per production type \ across the EU, 1st week of August 2020",
      xlab="NUmber of records")
dev.off()



#plot 2: production capacity per type
#aggregation or production capacity per type
df_agg_type <- aggregate(
  df$InstalledGenCapacity,
  by = list ( df$ProductionTypeName ) ,
  FUN = sum
)

head ( df_agg_type )
colnames ( df_agg_type ) <- c (
  "ProductionTypeName",
  "InstalledGenCapacity_sum"
)

df_agg_type$InstalledGenCapacity_sum <- df_agg_type$InstalledGenCapacity_sum * 0.001
df_agg_type <- df_agg_type [ order ( df_agg_type$InstalledGenCapacity_sum ), ]

#task: plot this as Barplot in ggplot2