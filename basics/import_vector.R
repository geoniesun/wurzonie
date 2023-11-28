#reading and writing vector data


#with sf
x <- sf::st_read("path/vectorfile.gpkg")
df::st_write(x, "path/newfile.gpkg")

#with sp
x <- rgdal::readOGR("path/file.gpkg")
rgdal::writeOGR(x, "path/newfile.gpkg",
                layer = "myname", driver = "GPKG")

#with terra
x <- terra::vect("path/file.gpkg")
terra::writeVector(x,"path/newfile.gpkg")