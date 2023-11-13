#install.packages("ggstatsplot")
install.packages("rstantools")

library(ggstatsplot)
library(RCurl)
library(ggplot2)
library(rstantools)

df <- read.csv("https://raw.githubusercontent.com/wegmann/R_data/master/Steigerwald_sample_points_all_data_subset_withNames.csv", header = TRUE)

df

#first some normal plotting
ggplot(df, aes(x=LCname, y=L8.savi)) +
  geom_jitter(aes(alpha=SRTM, size=TimeScan.NDVIsd, colour=L8.ndvi))+
  geom_boxplot(alpha=.5)

ggplot(df, aes(x=L8.ndvi, y = L8.savi)) +
  geom_point(size=2)+
  geom_point(aes(color=LCname), size=2)+
  facet_grid(. ~ LCname)

#now lets do stats
#with another dataset
set.seed(123)

ggbetweenstats(
  data  = iris,
  x     = Species,
  y     = Sepal.Length,
  title = "Distribution of sepal length across Iris species"
)


#try with df but its a lot indexed and should not be actually
set.seed(123)

df2 <- df[1:500,]
df2 <- df2[c(34,45)]
ggbetweenstats(
  data  = df2,
  x     = LCname,
  y     = L8.ndvi,
  title = "Distribution of sepal length across Iris species"
)

set.seed(123)

ggbetweenstats(
  data  = df,
  x     = L8.savi,
  y     = L8.ndvi,
  title = "test"
)

#now we combine with ggplot2
## loading the needed libraries
set.seed(123)
library(ggplot2)

## using `{ggstatsplot}` to get expression with statistical results
stats_results <- ggbetweenstats(data  = df,
                                x     = L8.savi,
                                y     = L8.ndvi,
                                title = "test") %>% extract_subtitle()

## creating a custom plot of our choosing
ggplot(morley, aes(x = as.factor(Expt), y = Speed)) +
  geom_boxplot() +
  labs(
    title = "Michelson-Morley experiments",
    subtitle = stats_results,
    x = "Speed of light",
    y = "Experiment number"
  )data  = df,
  x     = L8.savi,
  y     = L8.ndvi,
  title = "test"