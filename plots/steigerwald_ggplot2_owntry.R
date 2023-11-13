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

basic <- ggplot(df, aes(x=df$L8.ndvi, y=df$L8.savi)) +
  geom_point(aes(color=df$LCname),size=2)+
  facet_grid(.~LCname)

basic + theme(
  plot.background = element_rect(fill = "green"), 
  panel.background = element_rect(fill = "red", colour="blue")
)


basic <- ggplot(df, aes(x=df$L8.ndvi, y=df$L8.savi)) +
  geom_point(aes(color=df$LCname),size=2)+
  facet_grid(.~LCname)

basic + theme(
  plot.background = element_rect(fill = "green"), 
  panel.background = element_rect(fill = "red", colour="blue")
)
