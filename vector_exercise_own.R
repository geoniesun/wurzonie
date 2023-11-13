#exercise for vectors

some <- c(3:8)
some

some.2 <- c(3:8) #same as some
some.3 <- c(3:8) #same as some
#or
some.3 <- some.2

some.3[5] #still has value 7
some.3[5] <- 78 #now you changed position 5 from value 7 to 78
some.3

some.3[-3] #all but the third position not

some.3 == 4 #gives "TRUE" and "FALSE" in the data about which is 4

#asking which have value 4

which(some.3 == 4)
which(some.3 > 4)
which(some.3 <=5)

#doing it without command "which"
n <- length(some.3)
pages = 1:n #to get the indeces
pages[some.3 == 3]

x <- some.3 - some.2 # difference of both vectors

data.entry(x) #useful spreadsheet pops up

table(cut(some.3, breaks = 6)) #gives groups and shows how often the data appears in it
