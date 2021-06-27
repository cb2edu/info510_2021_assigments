isolate_numeric_col<- function(df){
  return(df[,unlist(lapply(df, function(x){class(x)=="numeric" | class(x) == "integer" }))])
}