install.packages("ggplot2")
library(ggplot2)
x <- data.frame(x=1,y=1,label="ggplot2 introduction \n@ EAGLE")
ggplot(data=x, aes(x=x, y=y)) + geom_text(aes(label=label), size=15)
  
