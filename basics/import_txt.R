my.df <- read.table("test_to_import.txt", #my file
                    header = TRUE, #defines if first consists of names not values
                    sep = "/" #defines how columns are separated, just open it in a text editor to check
)

#optional:
#dec = "." #defines the decimal separator
#na.strings="NA" #defines how NAs are identifies can be changes e.g. a number
#stringsAsFactors=TRUE #if variables are converted to character type (FALSE)

my.df
