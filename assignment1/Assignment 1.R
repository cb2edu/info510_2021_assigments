# Assignment 1
# Author: Kyle Cichos

# Write a function that will return only numeric columns in any dataframe... look through columns, use class function(numeric) and keep only numeric class values while remove everything else
nums <- unlist(lapply(x, is.numeric))
data_nums <- x[ , nums]
data_nums

# Where "x" is a data list