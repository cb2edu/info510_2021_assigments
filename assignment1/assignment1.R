#This function will only return numeric columns from a given data set "x"
nums <- unlist(lapply(x, is.numeric))
x[,nums]