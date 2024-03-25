install.packages("packages/rgdal_1.6-7.tar.gz", repos = NULL, type = "source")

packageurl <- "https://cran.r-project.org/src/contrib/Archive/rgdal/rgdal_1.6-7.tar.gz"
install.packages(packageurl, repos=NULL, type="source")

library(devtools)


RS <- "https://cran.r-project.org/src/contrib/Archive/RStoolbox/RStoolbox_0.3.0.tar.gz"
install.packages(RS, repos=NULL, type="source")
