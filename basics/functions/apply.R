#create matrix
m <- matrix(data=cbind(rnorm(30,0), rnorm(30,2), rnorm(30,5)), nrow=30, ncol=3)
m

mean(m[,1])
mean(m[,2])

#or
m.mean <- vector()
for (i in 1:ncol(m)){m.mean[i] <- mean(m[,1])}
 #get the mean for all rows
apply(m,1,mean)
#get the mean for all columns
apply(m,2,mean)

#stats to execute: mean or range, sum, fivenum etc.

#function queries the length of x values below 0
apply(m, 2, function(x) length(x[x<0]))

apply(m, 2, function(x) mean(x[x>0]))

sapply(1:3, function(x) x^2)

lapply(1:3, function(x) x^2)

x <- list(a=1:10, beta=exp(-3:3), logic=c(T,F,F,T))

lapply(x,mean)


