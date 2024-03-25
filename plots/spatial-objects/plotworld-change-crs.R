#plotting spatial vector objects - sp

library(ggplot2)
library(sf)
library(maps)

usa = st_as_sf(map('usa', plot=F, fill=T))
ggplot() + geom_sf(data = usa)

laea = st_crs("+proj=laea +lat_0=30 +lon_0=-95") #lambert equal area
usa <- st_transform(usa, laea)

ggplot() + geom_sf(data = usa)

ggplot() +
  geom_sf(data = usa, aes(fill = ID)) + 
  scale_y_continuous()
