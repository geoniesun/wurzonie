#there are different packages how to import or download data csv


#1
install.packages("RCurl")
library(RCurl)

df <- read.csv("https://raw.githubusercontent.com/wegmann/R_data/master/Steigerwald_sample_points_all_data_subset_withNames.csv", header = TRUE)

df

#1
install.packages("tidyverse")
library(tidyverse)
df2 <- read_csv("https://raw.githubusercontent.com/wegmann/R_data/master/Steigerwald_sample_points_all_data_subset_withNames.csv")
df2
#then you can explore the raw data that you just imported
head(df2)
summary(df2)
tail(df2)
plot(df2)
str(df2)

