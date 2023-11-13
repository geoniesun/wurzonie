#exploring commands

c <- rnorm(10)
c

table(cut(c,breaks=-2:1))
table


#tables
a <- letters[1:3] #creating chr a,b,c

a
str(a)
head(a)

table(a, sample(a)) #makes a random table of 0 and 1 for a,b,c

