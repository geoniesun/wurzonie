#sp to sf conversion

library(sf)

filename <- system.file("shape/nc.shp", package="sf")
nc <- st_read(filename)
class(nc)

st_write(nc, "nc.shp")

#convert to sp
nc.sp <- as(nc, "Spatial")
class(nc.sp)
nc.sp

#convert to sf

nc2 <- st_as_sf(nc.sp)

class(nc2)
all.equal(nc, nc2)
