# Please Ignore, specific to a bug in the gallery
library(pacman)
pacman::p_unload(pacman::p_loaded(), character.only = TRUE)

# Load libraries
library(dplyr)        # data wrangling
library(cartogram)    # for the cartogram
library(ggplot2)      # to realize the plots
library(broom)        # from geospatial format to data frame
library(tweenr)       # to create transition dataframe between 2 states
library(gganimate)    # To realize the animation
library(maptools)     # world boundaries coordinates
library(viridis)      # for a nice color palette

# Get the shape file of Africa
data(wrld_simpl)
afr=wrld_simpl[wrld_simpl$REGION==2,]

# A basic representation
plot(afr)

# construct a cartogram using the population in 2005
afr_cartogram <- cartogram(afr, "POP2005", itermax=7)

# A basic representation
plot(afr_cartogram)

# Transform these 2 objects in dataframe, plotable with ggplot2
afr_cartogram_df <- tidy(afr_cartogram) %>% left_join(. , afr_cartogram@data, by=c("id"="ISO3")) 
afr_df <- tidy(afr) %>% left_join(. , afr@data, by=c("id"="ISO3")) 

# And using the advices of chart #331 we can custom it to get a better result:
ggplot() +
  geom_polygon(data = afr_df, aes(fill = POP2005/1000000, x = long, y = lat, group = group) , size=0, alpha=0.9) +
  theme_void() +
  scale_fill_viridis(name="Population (M)", breaks=c(1,50,100, 140), guide = guide_legend( keyheight = unit(3, units = "mm"), keywidth=unit(12, units = "mm"), label.position = "bottom", title.position = 'top', nrow=1)) +
  labs( title = "Africa", subtitle="Population per country in 2005" ) +
  ylim(-35,35) +
  theme(
    text = element_text(color = "#22211d"), 
    plot.background = element_rect(fill = "#f5f5f4", color = NA), 
    panel.background = element_rect(fill = "#f5f5f4", color = NA), 
    legend.background = element_rect(fill = "#f5f5f4", color = NA),
    plot.title = element_text(size= 22, hjust=0.5, color = "#4e4d47", margin = margin(b = -0.1, t = 0.4, l = 2, unit = "cm")),
    plot.subtitle = element_text(size= 13, hjust=0.5, color = "#4e4d47", margin = margin(b = -0.1, t = 0.4, l = 2, unit = "cm")),
    legend.position = c(0.2, 0.26)
  ) +
  coord_map()

# You can do the same for afr_cartogram_df