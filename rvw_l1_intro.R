install.packages("terra","sf","geodata","rnaturalearth")
#to activate the packages you must do the library command
library(terra)
library(sf)
library(geodata)
library(rnaturalearth)

#mal kolumbien als beispiel

kol <- ne_countries(scale = 50, country = "germany", returnclass = "sf")
#plot(kol)

#mal das clima dort anschauen

#clikol <- geodata::worldclim_global(var="tmin", res=10, download='T',path='.')
#plot(clikol)

kolcli = worldclim_country("Germany", var="tmax", path=".")
#plot(kolcli)

kol.r <- st_transform(kol, st_crs(kolcli))
#plot(kol.r)

kol.crop <- terra::crop(kolcli, kol.r)
kol.mask <- terra::mask(kol.crop, kol.r)
plot(kol.mask)

climCol_vect <- terra::extract(kol.mask, kol)
climCol_vect
plot(unlist(climCol_vect))
plot(ne_countries(type = "countries", scale = "small"))
plot()

#to create pdfs
tinytex::install_tinytex()
library(tinytex)

