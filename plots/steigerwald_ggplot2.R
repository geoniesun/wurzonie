#1
install.packages("RCurl")
library(RCurl)
library(ggplot2)

df <- read.csv("https://raw.githubusercontent.com/wegmann/R_data/master/Steigerwald_sample_points_all_data_subset_withNames.csv", header = TRUE)

df


head(df)
summary(df)
tail(df)
plot(df)
str(df)

#this is from Martin: we check fist que onda
names(df)
head(df)
#then we create an empty plot
ggplot(df, aes(x=L8.ndvi, y=L8.savi))
#then a scatterplot
ggplot(df, aes(x=L8.ndvi, y=L8.savi)) + geom_point()
#adding more information with color
ggplot(df, aes(x=L8.ndvi, y=L8.savi, color=SRTM)) + geom_point()
#adding a smoothed lines
ggplot(df, aes(x=L8.ndvi, y=L8.savi, color=SRTM)) + geom_point() + geom_smooth()
#split the plots by landcover
ggplot(df, aes(x=L8.ndvi, y=L8.savi, color=SRTM)) + geom_point() + geom_smooth() + facet_wrap(LCname)

#plot SAVI values per landcover class
ggplot() + geom_point(data=df, aes(LCname, L8.savi))
#we add color 
ggplot() + geom_point(data=df, aes(LCname, L8.savi, colour=SRTM))
#more informative
#try boxplot with point "jitter"
ggplot(df, aes(x=LCname, y=L8.savi)) +
  geom_boxplot(alpha=.5)
#we do not see the number of points - add jitter
ggplot(df, aes(x=LCname, y=L8.savi)) +
  geom_boxplot(alpha=.5) +
  geom_point(aes(color=SRTM), alpha=.7, size=1.5, position=position_jitter(width = .25,height=0))


#more exploring
ggplot(df, aes(x=LCname, y=L8.savi)) +
  geom_jitter()
#adding color
ggplot(df, aes(x=LCname, y=L8.savi, colour=SRTM)) +
  geom_jitter()
#further options
ggplot(df, aes(x=LCname, y=L8.savi, colour=SRTM)) +
  geom_violin()
#or more:
ggplot(df, aes(x=TimeScan.NDVIavg, fill=LCname)) +
  geom_density(alpha=0.2)
#some stuff combined
ggplot(df, aes(x=LCname, y=L8.savi)) +
  geom_jitter(aes(alpha=SRTM, size=TimeScan.NDVIsd, colour=L8.ndvi))+
  geom_boxplot(alpha=.5)

#now we do the cover
ggplot(df, aes(x=L8.ndvi, y = L8.savi)) +
  geom_point(size=2)+
  geom_point(aes(color=LCname), size=2)+
  facet_grid(. ~ LCname)

##export it
pdf("landcover_vs_L8savi_ndvi.pdf", width=12,height=4)
ggplot(df, aes(x=L8.ndvi, y = L8.savi)) +
  geom_point(size=2)+
  geom_point(aes(color=LCname), size=2)+
  facet_grid(. ~ LCname)
dev.off()


