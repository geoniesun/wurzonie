#didn't manage to install animove
install.packages("remotes")
library(remotes)
remotes::install_github("AniMoveCourse/animove_R_package")

library(RStoolbox)

install.packages("animove")
library(animove)
library(rgdal)
install.packages("MODIStsp")

data(buffalo_env)
data(buffalo_utm)

#plot buffalo tracks on top of NDVI layer
buffalo_df <- data.frame(buffalo_utm)
ggp <- ggR(buffalo_env, layer="mean_NDVI", geom_raster =T) +
  scale_fill_gradient(low="gold", high="darkgreen")

ggp + geom_path(data=buffalo_df, aes(x=coords.x1, y=coords.x2), alpha = 1)

#hillshade (blend local illumination map with elevation layer)
terrainVariables <- terrain(buffalo_env[["elev"]], c("slope", "aspect"))
hillShade <- hillShade(terrainVariables$slope, terrainVariables$aspect, angle = 10)

ggR(hillShade) +
  ggR(buffalo_env, layer = "elev", alpha = 0.3,
      geom_raster=T, ggLayer = T) +
  scale_fill_gradientn(name = "Elevation (m)", colors=terrain.colors(100)) +
  geom_point(data=buffalo_df, aes(x=coords.x1, y = coords.x2), 
             alpha = .1, size=.5) +
  theme(axis.text.y = element_text(angle=90),
        axis.title = element_blank())
