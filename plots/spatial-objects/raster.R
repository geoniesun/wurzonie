#extract the underlying data frame values, requires 'raster' package
#you need to install the archives of rgdal and rstoolbox -> help_henning.R

install.packages("RStoolbox")
library(raster)
library(ggplot2)
library(RStoolbox)


#lsat comes from rstoolbpx package but we can use it as df in ggplot2
lsat.df <- data.frame(coordinates(lsat), getValues(lsat))
#plot and specify band
ggplot(lsat.df) + geom_raster(aes(x=x, y=y, fill=B2_dn)) +scale_fill_gradient(na.value=NA) +coord_equal()

#adding another color scheme
ggplot(lsat.df) + geom_raster(aes(x=x, y=y, fill=B2_dn)) +
  scale_fill_gradient(low="black", high = "white", na.value = NA) +coord_equal()



#plot it normally with RSToolbox
data(lsat)

#single layers
plot(lsat[[1]]) #base graphics
ggR(lsat, 1) #ggplot2

#multiple layers
plot(lsat)
ggR(lsat, 1:7, geom_raster=T)


#rgb plot with linear stretch
ggRGB(lsat, 3,2,1, stretch="lin")

ggR(lsat, layer=4, stretch = "lin", geom_raster = T) + 
  scale_fill_gradient(low="blue", high="green")

#limit the extent
lim <- extent(lsat) # thats the extent of lsat

#use stored plot plus new plotting commands
# I didnt make "a" before
a + guides(fill=guide_colorbar()) +
  geom_point(data=plots, aes(x=V1, y=V2),shape=3, colour="yellow") +
  theme(axis.title.x=element_blank()) +
  scale_x_continuous(limits=c(lim@xmin, lim@xmax))+ylim(c(lim@ymin, lim@ymax))

