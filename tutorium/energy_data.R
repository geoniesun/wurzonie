library(dplyr)
# Energy production across Europe per Power Unit
df_energy <- read_csv("C:/eagle/wurzonie/day2_data_energy_prod_EU_2020-08-03_2020-08-09.csv", show_col_types = FALSE)

names(df_energy)
head(df_energy)

# countries -> CLEAN
names(table(df_energy$MapCode)) 
# or
elements_df <- unique(df_energy$MapCode)
length(elements_df)

# number of records
dim(df_energy)
nrow(df_energy)

# what type/structure/class is this? POSIXct/POSIXt -> MAKE THIS SORTABLE (= NOT CHARACTER; FOR ME IT IS ALREADY NOT CHARACTER)
class(df_energy$DateTime)
df_energy$DateTimePOS <- as.POSIXct(df_energy$DateTime)

x11()
plot(df_energy$InstalledGenCapacity, df_energy$ActualGenerationOutput)
mean(df_energy$ActualGenerationOutput, na.rm=TRUE)
mean(df_energy$InstalledGenCapacity, na.rm=TRUE)

# clean outliers in ActualGenerationOutput since there are cases where ActualGenerationOutput is
# higher than InstalledGenCapacity
nrow_df_energy_not_cleaned <- nrow(df_energy)
df_energy <- df_energy[df_energy$ActualGenerationOutput < df_energy$InstalledGenCapacity*4, ] # or with ! and ActualGenerationOutput > InstalledGenCapacity
x11()
plot(df_energy$InstalledGenCapacity, df_energy$ActualGenerationOutput)


