
library(data.table)
swiss_wide <- data(swiss)

swiss_wide <- as.data.table(swiss_wide)

swiss_wide$Education <- factor(swiss_wide$Education)
library(reshape2)

library("dplyr")

swiss_wide <- swiss_wide %>% mutate(id = row_number())
swiss

swiss2 <- melt(swiss, id.vars=c("id", "Agriculture"))

melt(swiss_wide, id.vars = c("id"))


library("dplyr")

swiss_wide <- swiss_wide %>% mutate(id = row_number())

swiss_long <- melt(swiss_wide,
                   id.vars=c("id", "Education"),
                   measure.vars=c("Catholic", "Examination", "Fertility"),
                   variable.name="method",
                   value.name="measurement")
