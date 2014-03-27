# This is a program we are going to build to study inflammation data

#import the libraries what we will need
install.packages("ggplot2", dependencies=TRUE) # install.packages only needs to be run the first time you have a new package
library(ggplot2)

#set my working directory
wd = "/Users/sarah/documents/github/2014-03-17-nyu-R/instructor_notes/R"
setwd(wd)

#load in my data
data <- read.csv("data/inflammation-01.csv", header = FALSE, sep = ",")

#source my special functions
source("bootcamp_fxns.R")
source("second_fxns.R")
source('rblocks.R') #an in-development package for visually thinking about dataframes

# summarize information about my data
class(data)
str(data)
dim(data)
head(data)
tail(data)
nrow(data)
ncol(data)
names(data)

#subset the data by rows and columns
d <- data[20:25,]
sub <- data[3:3, 4:4]
sub2 <- data[3:3, 4:1]

#convert to a matrix
datamatrix <- as.matrix(data)
str(datamatrix)

average <- mean(datamatrix)
average
print(paste("the average inflammation is:", average))

#using apply functions to summarize the data by row (patient) and column (day)
help(apply)

avg_inflammation <- apply(data, 2, mean)
min_inflammation <- apply(data, 2, min)
max_inflammation <- apply(data, 2, max)
sd_inflammation <- apply(data, 2, sd)
days = c(1:40)

daysummary <- data.frame(days, avg_inflammation, min_inflammation, max_inflammation)

patient_avg <- apply(data, 1, mean)
patient_min <- apply(data, 1, min)
patient_max <- apply(data, 1, max)
patient_sd <- apply(data, 1, sd)

patientsummary <- data.frame(patient_avg, patient_min, patient_max, patient_sd)

plot(daysummary$days, daysummary$avg_inflammation)
hist(avg_inflammation)

#ggplot has a more advanced, "pretty" plotting system. But the syntax is different from anything else in R
ggplot(summary, aes(days, avg_inflammation)) + geom_line(col="red") + geom_point()


#write a function to analyze the data
analyze = function(filename){
  data = read.csv(filename)
  
  avg_inflammation = apply(data, 2, mean)
  max_inflammation = apply(data, 2, max)
  min_inflammation = apply(data, 2, min)
  time = c(1:ncol(data))
  
  plot(time, avg_inflammation, type = "b") #makes both points and lines
  plot(time, min_inflammation, type = "l") #makes a line
  plot(time, max_inflammation, type = "p") #points only
}

# analyze the data using the function
analyze('data/inflammation-01.csv')
analyze('data/inflammation-02.csv')

#but we don't really want to do it for all of them separately...
# so we can make a vector with all of the filenames in it, and loop over each of the files to analyze:

filenames = list.files(pattern = "*.csv", recursive = TRUE)

for (f in 1:length(filenames)){
  print (filenames[f])
  analyze(filenames[f])
}


#write a function to make a heat map of the data
dim(data)
height = nrow(data)
width = ncol(data)
heat_map = block_grid(height, width, type="matrix")

for (x in seq(1:height)){
  for (y in seq(1:width)){
    if (data[x, y] < average){
      heatmap[x, y] = "red"
    } 
    else if (data[x, y] == average){
      heatmap[x, y] = "green"
    }
    else{
      heatmap[x, y] = "blue"
    }
  }
}

heatmap

