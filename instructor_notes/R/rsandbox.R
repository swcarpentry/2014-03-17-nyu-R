# This is my R code for the bootcamp

# load libraries

# set working directory
setwd("/Users/sarah/Documents/GitHub/2014-03-17-nyu-R/instructor_notes/R")

# read the data
data = read.csv("data/inflammation-01.csv", header=F)

source("rblocks.R")
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

total = function(vector){
  #calculates the sum of the values in a vector
  sum = 0
  for (i in 1:length(vector)){
    sum = sum + vector[i]
  }
  return(sum)
}


num = 37
if (num > 100) {
  print ('greater')
}
else{
  print ('not greater')
}  
print ('done')


num = 53
print ('before conditional...')
if (num > 100){
  print ('53 is greater than 100')
}
print ('...after conditional')



sign = function(num){
  if (num > 0){
    return (1)
  }
  else if (num == 0){
    return (0)
  }
  else{
    return (-1)
  }
}
print (paste('sign of -3:', sign(-3)))

if (1 > 0 & -1 > 0){
  print ('both parts are true')
}



if (1 < 0 | 'left' < 'right'){
  print ('at least one test is true')
}


print ('empty string is true') 
if ('word'){ print ('word is true')} 
if ([]){ print 'empty list is true'} if ([1, 2, 3]){ print 'non-empty list is true'}))
if 0: print 'zero is true' if 1: print 'one is true'

near = function(param1, param2){
  #returns True if its first parameter is within 10% of its second and False otherwise.
  ten_percent = param2 * 0.1
  if (param1 >= (param2 - ten_percent) & param1 <= (param2 + ten_percent)){
    return (TRUE)
  }
  else {
    return(FALSE)
  }
}


numbers = c(-5, 3, 2, -1, 9, 6)
total = 0
for (n in 1:length(numbers)){
  if (numbers[n] >= 0){
    total = total + numbers[n]
  }
} 
print (paste('sum of positive values:', total))

pos_total = 0
neg_total = 0
for (n in 1:length(numbers)){
  if (numbers[n] >= 0){
    pos_total = pos_total + numbers[n]
  }
  else{
    neg_total = neg_total + numbers[n]
  }
}
print (paste('negative and positive sums are:', neg_total, pos_total))

for (consonant in 1:nchar('bcd')){
  for (vowel in 1:nchar('ae')){
    print (c(consonant, vowel))
  }
}

square = ImageGrid(5, 5)
for x in range(square.width):
  for y in range(square.height):
  if x < y:
  square[x, y] = colors['Fuchsia']
elif x == y:
  square[x, y] = colors['Olive']
else:
  square[x, y] = colors['SlateGray']
square.show()

height = 5
width = 5
square = block_grid(height, width, type="matrix")
for( x in 1:5){
  for (y in 1:5){
    if (x < y){
      square[x,y] = "hotpink"
    }
    else if (x == y) {
      square[x,y] = "Gray40"
    }
    else{
      square[x,y] = "chartreuse"
    }
  }
}
square


mean = mean(as.matrix(data))
height = nrow(data)
width = ncol(data)
heatmap = block_grid(height, width, type="matrix")

for (x in seq(1:height)){
  for (y in seq(1:width)){
    if (data[x, y] < mean){
      heatmap[x, y] = "red"
    } 
    else if (data[x, y] == mean){
      heatmap[x, y] = "green"
    }
    else{
      heatmap[x, y] = "blue"
    }
  }
}


flipped = t(data)
height = nrow(flipped)
width = ncol(flipped)
center = mean(as.matrix(flipped))

heatmap = block_grid(height, width, type="matrix")

for (x in seq(1:height)){
  for (y in seq(1:width)){
    if (flipped[x, y] < (0.8 * center)){
      heatmap[x, y] = "lightpink"
    } 
    else if (flipped[x, y] > (1.2 * center)){
      heatmap[x, y] = "deeppink4"
    }
    else{
      heatmap[x, y] = "hotpink"
    }
  }
}

heatmap


make_heatmap = function(values, low_band=0.5, high_band=1.5, low_color="gray60", 
                        mid_color="chartreuse", high_color="darkgreen"){
  height = nrow(values)
  width = ncol(values)
  result = block_grid(height, width, type="matrix")
  center = mean(as.matrix(values))
  
  for (x in seq(1:height)){
    for (y in seq(1:width)){
      if (values[x, y] < (low_band * center)){
        result[x, y] = low_color
      } 
      else if (values[x, y] > (high_band * center)){
        result[x, y] = high_color
      }
      else{
        result[x, y] = mid_color
      }
    }
  }
  return(result)
}
  


