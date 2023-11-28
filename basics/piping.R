install.packages("babynames")
library(babynames)
library(dplyr)

temp1 <- filter(babynames, sex=="M",name=="Taylor")
temp2 <- select(temp1,n)
temp3 <- sum(temp2)

sum(select(filter(babynames,sex=="M",name=="Taylor"),n))

#piping

babynames %>% filter(sex=="M",name=="Taylor") %>%
  select(n) %>%
  sum 


#my example
babynames[25:50,] %>% filter(sex=="F") %>%
  select(n) %>%
  sum 

quote(babynames |> filter(sex=="M",name=="Taylor") |>
        select(n) |>
        sum)
quote(babynames |> filter(sex=="M",name=="Taylor") |>
        select(n) |>
        sum)

quote(babynames %<% head())

#iris

data <- iris
data

iris |>
  head() |>
  summary()

quote(iris |>
        head() |>
        summary())


  
