
install.packages("fun")
library(fun)

#this is because of windows
if (interactive()) {
  if (.Platform$OS.type == "windows")
    x11() else x11(type = "Xlib")
}

#play
mine_sweeper()

#check more:
#https://github.com/RLesur/Rcade
#https://github.com/jbkunst/rchess