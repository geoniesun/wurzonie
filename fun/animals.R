

#http://people.fas.harvard.edu/~izahn/posts/useless-but-fun-r-packages/

#install.packages("fortunes")
library(fortunes)
#call a quote:
fortune()
#call and search for a quote topic
fortune("memory")


#install.packages("cowsay")
library(cowsay)
say("hello world")
#change it a bit
someone_say_hello <- function() {
  animal <- sample(names(animals), 1)
  say(paste("hello, I am a ", animal, ".", collaplse = ""), by = animal)
}
someone_say_hello()

someone_say_my_fortune <- function() {
  animal <- sample(names(animals), 1)
  say(paste(fortune(), collapse = "\n"), by = animal)
}

 

someone_say_my_fortune()


