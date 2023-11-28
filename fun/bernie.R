install.packages("remotes")
library(ggplot2)
library(remotes)
install.packages("ggcats")
library(ggcats)


remotes::install_github("R-CoderDotCom/ggcats@main")
mtcars
ggplot(mtcars) +
  geom_cat(aes(mpg, wt), cat = "pop", size = 5)




ggplot(df) +
  geom_cat(aes(x, y, cat = image), size = 5) +
  xlim(c(0.25, 5.5)) + 
  ylim(c(0.25, 3.5))

remotes::install_github("R-CoderDotCom/ggbernie@main", force=T)
install.packages("ggbernie")
library(ggbernie)
ggplot(mtcars) +
  geom_bernie(aes(mpg, wt), bernie = "stand")
geom_bernie