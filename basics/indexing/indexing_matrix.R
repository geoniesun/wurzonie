
#matrix

m1 <- matrix(c(1:12), nrow = 3)
m1


#with defined rows and columns and how to fill it in
m2 <- matrix(
  c(1:12),
  nrow=3,
  ncol=4,
  byrow = TRUE) # by row means if its going 1 2 3 by row or column
m2

m1[,2] #query 2. col
m1[2,] #query 2. row
m1[2,2] # 2 row and column content



# c r e a t e a  v e c t o r  w i t h  8 0  e n t r i e s  b a s e d  o n  n o r m a l l y  d i s t r i b u t e d  d a t a
num_1 <- rnorm(80,mean=0,sd=1)
num_1

# p u p u l a t e  m a t r i x  w i t h  v e c t o r d a t a  i n  2 0  r o w s  a n d  4  c o l u m n s
mat_1 <- matrix(num_1,nrow=20,ncol=4)
mat_1
mat_2 <- matrix(num_1,nrow=20,ncol=4, byrow= TRUE) #anders rum
mat_2


#convert that into dataframe
df3 <- data.frame(mat_1)
names(df3) <- c("a","f","k","j")
df3
summary(df3)
head(df3)
tail(df3)


#generate a dataframe with 2 columns
test <- data.frame(A=c(1,2,3),B=c("aB1","aB2","aAB3"))
test[,1]
test[,"A"]
test$B
str(test)
test


test2 <- data.frame(A=(1:10),B=c(11:20))
with(test2[(test2$B<4)&(test2$A<2)], plot(A,B)redo
