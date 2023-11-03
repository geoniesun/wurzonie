#check more games:
#https://github.com/RLesur/Rcade
#https://github.com/jbkunst/rchess

install.packages("sudoku")
library(sudoku)



#if(.Platform$OS.type ==”windows”) {
#  x11()
#} else {
#  x11(type = ”Xlib”)
#}


#for windows you need to make an interactive platform
if (interactive()) {
  if (.Platform$OS.type == "windows")
    x11() else x11(type = "Xlib")
}
playSudoku()

difftime("2023-12-24",Sys.Date(),units="days")
