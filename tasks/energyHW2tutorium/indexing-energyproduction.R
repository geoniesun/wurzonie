
library(readr)
file <- read.csv("data/day2_data_energy_prod_EU_2020-08-03_2020-08-09.csv")
View(file)

head(file)
str(file) 
dim(file) #[1] 301138     17
class(file) #data.frame
sum(file) #not working because omly for just numeric
summary(file)

pow.unit <- file$PowerSystemResourceName
temp_res <- file[c("Year", "Month","Day")]
actoutout <- file$ActualGenerationOutput
installedout <- file$InstalledGenCapacity
loc <- file$MapCode
class(loc)
str(loc)
cut(file$Year,breaks = 5) #how to check??

##how to count unique values in a column of a data.frame
length(unique(file$ProductionTypeName))
library(dplyr) #this does the same as above
n_distinct(file$ProductionTypeName)

#check some stats of the columns
#you have to check for NA, so here I removes it in the end
mean(file$ActualGenerationOutput, na.rm=T)
max(file$ActualGenerationOutput, na.rm=T)
min(file$ActualGenerationOutput, na.rm=T)
median(file$ActualGenerationOutput, na.rm=T)
str(file$ActualGenerationOutput, na.rm=T)


mean(file$ActualConsumption, na.rm=T)
max(file$ActualConsumption, na.rm=T)
min(file$ActualConsumption, na.rm=T)
median(file$ActualConsumption, na.rm=T)
str(file$ActualConsumption, na.rm=T)

#making some plots
library(ggplot2)
ggplot(file, aes(InstalledGenCapacity, color = ProductionTypeName)) +
         geom_histogram()
