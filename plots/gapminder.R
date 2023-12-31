library(ggplot2)
install.packages("gganimate")
install.packages("gapminder")
library(gganimate)


theme_set(theme_bw())


library(gapminder)
head(gapminder)
#other DS
#Nile
#plot(Nile)

p <- ggplot(
  gapminder, 
  aes(x = gdpPercap, y=lifeExp, size = pop, colour = country)
) +
  geom_point(show.legend = FALSE, alpha = 0.7) +
  scale_color_viridis_d() +
  scale_size(range = c(2, 12)) +
  scale_x_log10() +
  labs(x = "GDP per capita", y = "Life expectancy")
p


#now make it move
p + transition_time(year) +
  labs(title = "Year: {frame_time}")


#by continent
p + facet_wrap(~continent) +
  transition_time(year) +
  labs(title = "Year: {frame_time}")
