

Remove_non_numeric <- function(raw_data)
  {for (i in 1:length(names(raw_data))) 
    {if (class(raw_data[,i]) != "numeric") 
      {raw_data <- raw_data[,-i]
       }
  }
  return(raw_data) 
}


Remove_non_numeric(iris)
