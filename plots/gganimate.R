library(RCurl)
df <- read.csv("E:/Eagle/courses/introprogramming/EAGLE_course_ggplot - Form responses 1.csv")
summary(df)

df1 <- data.frame(df[,c(2:6,10,14)], semester=1, courses=11)
df2 <- data.frame(df[,c(2:5,7,11,15)], semester=2, courses=15)
df3 <- data.frame(df[,c(2:5,8,12,16)],semester=3, courses=2)
df4 <- data.frame(df[,c(2:5,9,13,17)],semester=4, courses=3)

df.names <- c("eyecol","haircol","glasses","sex", "progExp", "eoExp", "praesExp", "semester", "courses")

names(df1) <- df.names
names(df2) <- df.names
names(df3) <- df.names
names(df4) <- df.names

df <- rbind(df1,df2,df3,df4)

library(ggplot2)
library(gganimate)
 p <- ggplot(data=df, aes(y=eoExp, x=progExp, color  =eyecol, size=sex)) +
   geom_point(alpha=0.8)
p 

p + transition_time(semester) +
  ease_aes('linear')+
  shadow_wake(wake_length = 0.1, alpha=F)+
  enter_fade()+
  exit_fade()

anim_save("eagle_students.gif")



