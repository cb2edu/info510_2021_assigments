data("iris")
View(iris)

# This function checks the given variable and returns TRUE 
#  if the variable is numeric
isNumeric <- function(x){
  #return TRUE if the datatype of 'x' is numeric
  class(x) =="numeric"
}

#Test the function
n <- 5
isNumeric(n)

#Get numeric columns from iris data
# Method1
result = iris[, lapply(iris, isNumeric) == TRUE]
result


# Method2
result2 = iris[, lapply(iris, function(x)class(x) == "numeric") == TRUE]
result

# Method3
result3 = iris[, lapply(iris, is.numeric) == TRUE]
result3

