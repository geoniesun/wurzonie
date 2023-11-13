#there are different packages how to import or download data csv


#1
install.packages("RCurl")
library(RCurl)

df <- read.csv("https://raw.githubusercontent.com/wegmann/R_data/master/Steigerwald_sample_points_all_data_subset_withNames.csv", header = TRUE)

df


head(df)
summary(df)
tail(df)
plot(df)
str(df)

#selecting 3 columns
df[2:6,c('LUCAS_LC', 'S2.1', 'S2.2')]
#just Sentinel data

sentinel <- df[,c(4:13)]

#do it with gsub
#redo following
plot(sentinel, df$TimeScan.NDVImax)
plot(df$SRTM, df$MOD.ndvi)
plot(df$L7.ndvi, df$SRTM<260 & df$LCname=urban)

df_sel = rbind(df$SRTM<260, df$LCname )
head(df)
