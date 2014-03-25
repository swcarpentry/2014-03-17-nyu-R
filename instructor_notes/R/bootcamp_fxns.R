# Holds all the functions I need for my Science paper (Nature if not accepted...)
# Code written by S.R. Supp & SWC bootcamp, 2014


fahr_to_kelvin <- function(temp){
  # Function that converts Fahrenheit to Kelvin, takes temp in F as input
  kelvin <- ((temp - 32) * (5/9)) + 273.15
  return (kelvin)
}


kelvin_to_celsius <- function(temp){
  #converts kelvin to celsius
  c <- temp - 273.15
  return (c)
}


fahr_to_celsius <- function(temp){
  #converts fahrenheit to celsius
  temp <- fahr_to_kelvin(temp)
  temp <- kelvin_to_celsius(temp)
  return (temp)
}


fence <- function(outer, wrapper=1){
  #puts wrapper on beginning and end of outer
  out <- paste(wrapper, outer, wrapper, sep="")
  if (class(wrapper) == "character" | class(outer) == "character"){
    stop ("This is not numeric")
  }
  return(out)
}
