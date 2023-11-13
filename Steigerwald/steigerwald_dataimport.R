install.packages("RCurl")
library(RCurl)

df <- read.csv("https://raw.githubusercontent.com/wegmann/R_data/master/Steigerwald_sample_points_all_data_subset_withNames.csv", header = TRUE)

df

#then you can explore the raw data that you just imported
head(df)
summary(df)
tail(df)
plot(df)
str(df)
mode(df)