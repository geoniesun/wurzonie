#list can contain different objects with different size
#here two vectors of different size
#indexing therefore more difficult

a <- runif(199) #this is a vector
b <- c("aa","bb", "cc","dd","ee")
c <- list(a,b)

c[2] # index second object, output still a list
c[[2]] #same, but output is original data frame
c[[2]][1]


#more complex
d <- list(obj_1=runif(100),onj_2=c("aa", "bb"), onj_3=c(1,2,4))

#call the object name
d$obj_1
#or
d[["obj_1"]]
#or
d[[1]]

# a list with matrix, vector and data frame of different sizes
f <- list(m1=matrix(runif(50), nrow=5), v1=c(1,2,5), df1=data.frame(a=runif(100), b=rnorm(100)))
f$df1[,1]
