library(tidyverse)
library(osmdata)
available_tags("highway")
available_features()
getbb("Wasserburg am Inn")
getbb("Auckland New Zealand")

streets <- getbb("Wasserburg am Inn")%>%
  opq()%>%
  add_osm_feature(key = "highway", 
                  value = c("motorway", "primary", 
                            "secondary", "tertiary")) %>%
  osmdata_sf()
streets

small_streets <- getbb("Wasserburg am Inn")%>%
  opq()%>%
  add_osm_feature(key = "highway", 
                  value = c("residential", "living_street",
                            "unclassified",
                            "service", "footway")) %>%
  osmdata_sf()

river <- getbb("Wasserburg am Inn")%>%
  opq()%>%
  add_osm_feature(key = "waterway", value = "river") %>%
  osmdata_sf()

ggplot() +
  geom_sf(data = streets$osm_lines,
          inherit.aes = FALSE,
          color = "#ffbe7f",
          size = .4,
          alpha = .8) +
  geom_sf(data = small_streets$osm_lines,
          inherit.aes = FALSE,
          color = "#ffbe7f",
          size = .4,
          alpha = .6) +
  geom_sf(data = river$osm_lines,
          inherit.aes = FALSE,
          color = "#7fc0ff",
          size = 3,
          alpha = .5) +
  coord_sf(xlim = c(12.17, 12.25), 
           ylim = c(48.02, 48.08),
           expand = FALSE) 
theme_void() +
  theme(
    plot.background = element_rect(fill = "#282828")
  )
