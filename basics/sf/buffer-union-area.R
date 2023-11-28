#some sf operations

library(sf)

filename <- system.file("shape/nc.shp", package="sf")
nc <- st_read(filename)
class(nc)

nc.web_mercator <- st_transform(nc, 3857)

#select 3 polygons
sel <- c(1,5,14)
geom= st_geometry(nc.web_mercator[sel ,])
plot(geom)

#apply three buffer - positive and negative
buf <- st_buffer(geom, dist =40000)
plot(buf, border='red', add=T)

buf2 <- st_buffer(geom, dist=-3000)
plot(buf2, add=T, border="green")

buf3 <- st_buffer(geom, dist = -10000)
plot(buf3, add=T, border="blue")

#union all polygons
nc.u <- st_union(nc)
nc.u
plot(nc.u)

#compute area of polygon and change units
nc.area <- st_area(nc)
nc.area

units::set_units(nc.area, km^2)
