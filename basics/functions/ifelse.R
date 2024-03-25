a <- 5
if(a>0) #if a is larger than 0 print 
{
  print("yes it is true, it is larger")
}  

a <- 5
if(a !=5) 
{
  print("number is not equal 5")
} else {
  print("number is euqal 5")
}

set.seed(100)
abc <- sample(letters[1:5], 1000, replace=T)
df <- data.frame(v1=abc, v2="blank",stringsAsFactors = F)
head(df)
