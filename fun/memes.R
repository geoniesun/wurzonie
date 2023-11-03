#create memes

#details:
#https://github.com/sctyner/memer

install.packages("devtools")
devtools::install_github("sctyner/memer")
library(memer)

meme_get("DistractedBf") %>%
  meme_text_distbf("Earth Observation", "EAGLE student", "life")
