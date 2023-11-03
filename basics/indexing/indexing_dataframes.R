df_1 <- data.frame(plot="location_name_1", measure1=runif(100)*1000,measure2=round(runif(100)*100),
                   value=rnorm(100,2,1),ID=rep(LETTERS,100)[1:100])

df_2 <- data.frame(plot="location_name_2", measure1=runif(50)*100,measure2=round(runif(50)*10),
                   value=rnorm(50),ID=rep(LETTERS,50)[1:50])

df <- rbind(df_1,df_2)
df
df_1

#plot data frame but just for plot and measure 1 and 2
df[,c('plot', 'measure1', 'measure2')]

#plot df just for line 66 to 70 and plot m1 and m2
df[66:70,c('plot', 'measure1', 'measure2')]
