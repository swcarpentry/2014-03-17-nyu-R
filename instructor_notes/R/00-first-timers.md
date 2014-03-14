Novice R materials - following Python examples
--------------------------------------------------

* Draw concept map of where we are headed towards best scientific practices, and reproducibility.
* Its really important that you know what you did. More journals/grants/etc. are also making it important for them to know what you did.
* A lot of scientific code is NOT reproducible.
* If you keep a lab notebook, why are we not as careful with our code. 
* We edit each others manuscripts, but we don't edit each other's code. 
* If you write your code with "future you" in mind, you will save yourself and others a lot of time.

Introduction to R and RStudio
--------------------------------
Let's start by learning about our tool. 

_Point out the different windows in R._ 
* Console, Scripts, Environments, Plots

Avoid using shortcuts. 
Code and workflow is more reproducible if we can document everything that we do.
Our end goal is not just to "do stuff" but to do it in a way that anyone can easily and exactly replicate our workflow and results.

You can get output from R simply by typing in math
`3 + 5`
`12/7`

or by typing words, with the command "print"
`print ("hello world")

We can annotate our code (take notes) by typing "#". Everything to the right of # is ignored by R

We can save our results to an object, if we give it a name
`a = 60 * 60`
`hours <- 365 * 24`

Data types and structures
----------------------------
A vector is a one dimensional string of numbers, characters of objects. 
`x = c(1,2,3,4)`
`names = c("sarah", "tracy", "jonathan")`

vectors can only be one data type, so if we try to include multiple types, 
R will convert them to what it thinks they should be.
`times = c(10, 11, "noon")`

__Indexing__
Vectors have positions, these positions are ordered and can be called using name_vector[index]
`names[2]`

__Functions__
A function is a saved object that takes inputs to perform a task. 
Functions take in information and return desired outputs.

output = name_of_function(inputs)
`y = sum(x)`

__Help__
All functions come with a help screen. 
It is critical that you learn to read the help screens since they provide important information on what the function does, 
how it works, and usually sample examples at the very bottom.

__Install new functions__
To install any new package install.packages('ggplot2')

You can't ever learn all of R, but you can learn how to build a program and how to find help
to do the things that you want to do. Let's get hands-on.