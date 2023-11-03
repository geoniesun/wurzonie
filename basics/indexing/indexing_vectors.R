#indexing vector data
#vector can only be number or character
#vector with numbers
c <- c(3,4,6,7)
# a vector with characters
f <- c("jj", "jb", "bj")

#generate a vector
x <- seq(1,100,by=2.5) #sequence of 1 to 100 with 2.5 steps
str(x)
#query different sequtions or positions
x[4:55]
x[1:3]
x[4]


#extract last value
x[length(x)] # length of x and query this position 
x[length(x)-1] # length of x and query this minus one position

#extract all but one position
x[-2]

#this also works by interacting with other vectors as input
idx <-  c(1,5,9)
x[idx]
x[-idx]

#this gives TRUE or FALSE positions back
x>20 # all over 20
(x<=10) | (x>=30) # below or equal 10 OR above or equal 30
#and if you want actual values and not TRUE or FALSE:
x[x<10 | x>30]

#change values Version 1
x2 <- numeric(length(x)) #new vector with same length as x
x2[x<=30] <- 1
x2[(x>30) & (x<70)] <- 2
x2[x>70] <- 3
x2
#change values version 2
install.packages("car")
library(car)
x2 <- recode(x, "0:30=1; 30:70=2; else=3")

