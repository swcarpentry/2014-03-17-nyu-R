# R script for a log log plot of data from two files
# Created for SWC NYU R bootcamp
# 2014 March 17-18

# We're going to plot, so load the plotting library ggplot2
library(ggplot2)

# Set the working directory

wd = "/Users/tracyt/bootcamp/2014-03-17-nyu-R/example"
setwd(wd)


# Bring in the data
# read.table will read in any delimited file. Set sep = to however
# the file is delimited. Here it's delimited by tab and the 
# way to write tab for the computer is \t

control <- read.table("control.txt", header=FALSE, sep="\t")
exp <- read.table("experiment.txt", header=FALSE, sep="\t")

# Look at the data

summary(control)
class(control)
str(control)
dim(control)
head(control)

summary(exp)
class(exp)
str(exp)
dim(exp)
head(exp)

# We see that these two data sets each have 83 measures
# We want to compare the control and experimental data for each of these measures
# So we need to make a new data frame that contains both sets of data 
# for each measurement

# We only care about the first and second columns.  Let's take a look at them

control[,1:2]

# We're assuming that each of the 's' labels is a measure for that sample 's' and 
# that they are unique.  Let's test.

unique(control[,1])

# It says at the bottom that we have 83 Levels, so 83 unique values. We could
# also count that by seeing the length of the list

length(unique(control[,1]))

# Let's test this for exp too

length(unique(exp[,1]))

# Great there are 83 for each

# So, we want to merge these dataset
# Again we're assuming that there's one measure for each label in each
# dataset. Let's test that.

# Make a list of the names in the control and experiment
control_name <- control[,1]
exp_name <- exp[,1]

# Let's see how many are in both lists
# If there is one of each in each list, then there should be 83 that 
# are in each list
#
# 'union' creates a list of all the values that are the same in both lists
inboth <- union(control_name, exp_name)
length(inboth)

# 83 are in both, so we're good!

# So, we could merge the datasets with just the measurement values
# This merges the datasets, and it uses the values in the 'V1' column
# to match them to each other

all_values <- merge(control[,1:2], exp[,1:2], by="V1")

# But there's that third column that has some information about what
# type of data it is 'T'. We also want that information, so let's
# create a dataframe that includes that too.  We're going to take that 
# third column from the 'experiment' data frame and add it to our 
# data frame

all2 <- merge(all_values[,1:3], exp[,(1,3)], by="V1")

# We also could have done this in command, including that third column 
# originally

all <- merge(control[,1:2], exp[,1:3], by="V1")

# Let's take a look at our new data frame
str(all)
head(all)

# We see they have these generic titles V1, V2.x and V2.y
# We can change those to something meaningful so we remember which is which

colnames(all) <- c('chr','control','exp','label')

# Now look at it again
head(all)
summary(all)
# Now we can plot it

plot(all[,2], all[,3])

# or use the names of the columns
# To use the names of the columns, the format is 
# dataframe_name$column_name

plot(all$control, all$exp)

# This doesn't look very good, because it the data is such a range of values
# A log / log plot would be better

plot(log(all$control),log(all$exp))

# Looks better!
# Now let's try it in ggplot because it usually looks nicer

ggplot(all, aes(log(all$control),log(all$exp))) + 
  geom_point()

# Change the axis labels and title to something meaningful

ggplot(all, aes(log(control),log(exp))) +
  geom_point() +
  xlab("log(control)") +
  ylab("log(exp)") +
  ggtitle("Control versus Experiment") 

# Make each of the different labels, or treatments a different color
# super cool feature of ggplot!

ggplot(all, aes(log(control),log(exp))) +
  geom_point(aes(color=label), size=3) +
  xlab("log(control)") +
  ylab("log(exp)") +
  ggtitle("Control versus Experiment") 

# This looks really nice, but it's hard to tell the difference between the 
# colors. Let's pick a set of colors.

# See how many categories we have
num_categories <- length(unique(all$label))

colors <- colorRampPalette(c("blue", "red"))(num_categories) 

ggplot(all, aes(log(control),log(exp))) +
  geom_point(aes(color=label), size=3) +
  scale_colour_manual(values=colors) +
  xlab("log(control)") +
  ylab("log(exp)") +
  ggtitle("Control versus Experiment") 


# Actually I should have been doing this differently, and just using
# the scaling function for the plot
# rather than stating it explicitly, so this is a final good version

ggplot(all, aes(control, exp)) +
  geom_point(aes(color=label), size=3) +
  scale_colour_manual(values=colors) +
  xlab("log(control)") +
  ylab("log(exp)") +
  ggtitle("Control versus Experiment") +
  scale_x_log10() + scale_y_log10()


