#doesnt work for some reason


library(dbplyr)


nc = st_read(system.file("shape/nc.shp", package="sf"))
nc %>% filter(AREA>0.1) %>% plot()

#plot the ten smallest countries in grey

st_geometry(nc) %>% plot()
nc %>% select(AREA) %>% arrange(AREA) %>% slice(1:10) plot(add =T, col = 'grey')
