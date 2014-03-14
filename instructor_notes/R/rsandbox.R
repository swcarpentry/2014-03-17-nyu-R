# This is my R code for the bootcamp

# load libraries

# set working directory
setwd("/Users/sarah/Desktop/instructor_notes/R/data/")

# read the data
data = read.csv("inflammation-01.csv", header=F)

datamatrix = as.matrix(data)

avg_inflammation = c()
for (col in 1:ncol(datamatrix)){
  avg = mean(datamatrix[,col])
  avg_inflammation = append(avg_inflammation, avg)
}

max_inflammation = c()
for (col in 1:ncol(datamatrix)){
  m = max(datamatrix[,col])
  max_inflammation = append(max_inflammation, m)
}

min_inflammation = c()
for (col in 1:ncol(datamatrix)){
   m = min(datamatrix[,col])
  min_inflammation = append(min_inflammation, m)
}

time = c(1:40)

plot(time, avg_inflammation)
plot(time, min_inflammation)
plot(time, max_inflammation)

summary = data.frame(time, avg_inflammation, min_inflammation, max_inflammation)

ggplot(summary, aes(time, avg_inflammation)) + geom_point()

fahr_to_kelvin = function(temp){
  kelvin = ((temp - 32) * (5/9)) + 273.15
  return(kelvin)
}


print (paste('freezing point of water:', fahr_to_kelvin(32)))
print (paste('boiling point of water:', fahr_to_kelvin(212)))


kelvin_to_celsius = function(temp){
  C = temp - 273.15
  return (C)
  }

#converts fahrenheit to celsius
fahr_to_celsius = function(temp){
  temp = fahr_to_kelvin(temp)
  result = kelvin_to_celsius(temp)
  return (result)
}

species = ("dracena")

fence = function(outer, inner){
  #returns a new string
  new = paste(outer, inner, outer, sep="")
  return(new)
}



outer = function(word){
  letters = strsplit(word, "")[[1]]
  first = letters[1]
  last = letters[nchar(word)]
  abbrev = paste(first,last, sep="")
  return(abbrev)
}

z = matrix(data = 0, nrow = 2, ncol = 2)

plotdata = function(filename){
  data = read.csv(filename)
  plot(c(1:40),data[1,], type = "b")
}


display = function(a=1, b=2, c=3){
  print (paste('a:', a, 'b:', b, 'c:', c))
}
print (paste('no parameters:', display()))
print (paste('one parameter:', display(55)))
print (paste('two parameters:', display(55, 66)))
print (paste('three parameters:', display (55, 66, 77)))
no parameters:
  a: 1 b: 2 c: 3
one parameter:
  a: 55 b: 2 c: 3
two parameters:
  a: 55 b: 66 c: 3

analyze = function(filename){
  data = read.csv(filename)
  
  avg_inflammation = apply(data, 2, mean)
  max_inflammation = apply(data, 2, max)
  min_inflammation = apply(data, 2, min)
  
  time = c(1:ncol(data))
  
  plot(time, avg_inflammation)
  plot(time, min_inflammation)
  plot(time, max_inflammation)
}