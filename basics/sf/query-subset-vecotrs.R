#query and subset vector data


library(sf)
#spatial vector of germany
germanyQuery <- germany[germany$Name=="Bavaria"]

#subset based on value ranges from column "measurement"
germanyQuery <- germany[germany$measurement > 20,]

#sf allows to use pipes and filters
filter(germany$measurement >20)

#or with pipe
germany %>% filter(measuremnt > .1) %>% plot()