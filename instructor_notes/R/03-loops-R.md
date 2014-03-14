Analyzing Multiple Data Sets
=============================

We have created a function called analyze that creates graphs of the minimum, average, and maximum daily inflammation rates for a single data set:

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
	  
	analyze('inflammation-01.csv')
	
We can use it to analyze other data sets one by one:

	analyze('inflammation-02.csv')

but we have a dozen data sets right now and more on the way. We want to create plots for all our data sets with a single statement. To do that, we'll have to teach the computer how to repeat things.

Objectives
------------

* Explain what a for loop does.
* Correctly write for loops to repeat simple calculations.
* Trace changes to a loop variable as the loop runs.
* Trace changes to other variables as they are updated by a for loop.
* Explain what a list is.
* Create and index lists of simple values.
* Use a library function to get a list of filenames that match a simple wildcard pattern.
* Use a for loop to process multiple files.

For Loops
===========

Suppose we want to print each word in our sentence we defined earlier on a line of its own. 
One way is to use four print statements:

	print_words = function(sentence){
		print (sentence[1])
		print (sentence[2])
		print (sentence[3])
		print (sentence[4])
		print (sentence[5])
		}

	print_words(words)

but that's a bad approach for two reasons:

It doesn't scale: if we want to print the elements in a vector that's hundreds long, we'd be better off just typing them in.

It's fragile: if we give it a longer vector, it only prints part of the data, and if we give it a shorter one, it produces an error or gives us `NA` values because we're asking for elements that don't exist.

	hello = c("I", "was", "here")
	
	print_words(hello)
	
Here's a better approach:

	print_words = function(sentence){
		for(i in 1:length(sentence)){
			print(sentence[i])
			}
		}

This is shorter---certainly shorter than something that prints every character in a hundred-letter string---and more robust as well:

	print_words('oxygen')
	
The improved version of `print_words` uses a `for loop` to repeat an operation---in this case, printing---once for each thing in a collection. The general form of a loop is:

	for (variable in collection){
    	do things with variable
    }

We can call the loop variable anything we like, but there must be a curly brace `{` at the end of the line starting the loop, and we should indent the body of the loop.

Here's another loop that repeatedly updates a variable:

	length = 0
	for (vowel in 1:nchar('aeiou')){
    	length = length + 1
	print (paste('There are', length, 'vowels'))
	}

It's worth tracing the execution of this little program step by step. Since there are five characters in 'aeiou', the statement on line 3 will be executed five times. The first time around, length is zero (the value assigned to it on line 1) and vowel is 'a'. The statement adds 1 to the old value of length, producing 1, and updates length to refer to that new value. The next time around, vowel is 'e' and length is 1, so length is updated to be 2. After three more updates, length is 5; since there is nothing left in 'aeiou' for Python to process, the loop finishes and the print statement on line 4 tells us our final answer.

Note that a loop variable is just a variable that's being used to record progress in a loop. It still exists after the loop is over, and we can re-use variables previously defined as loop variables as well:

	letter = 'z'
	for (letter in 1:nchar('abc')){
    	print (substr('abc',letter, letter))
		print (paste('after the loop, letter is', letter))
		}
Note also that finding the length of a string is such a common operation that R actually has a built-in function to do it called len:

	print nchar('aeiou')
	
`nchar` is much faster than any function we could write ourselves, and much easier to read than a two-line loop. We can also use `length` to tell use the number of elements in a vector, the number of columns in a dataframe, or the number of cells in a matrix.

Challenges
------------  

1. R has a built-in function called seq that creates a list of numbers: `seq(3)` produces [1] 1, 2, 3, `seq(2, 5)` produces [1] 2, 3, 4,5, and `seq(2, 10, 3)` produces [1] 2, 5, 8. Using `seq`, write a function that prints the _n_ natural numbers:
	
		print_numbers = function(N){
			nseq = seq(N)
			for (i in 1:length(nseq)){
				print(nseq[i])
			}
		}
	
2. Exponentiation is built into R: `2**4`. Write a function called expo that uses a loop to calculate the same result.

3.  We can also apply some simple methods to R vectors. One of these is called `sort`. It works on numbers or letters: 

		sort(words)
		sort(words, decreasing = TRUE)

	Write a function called rev that does the same thing. As always, be sure to include a docstring.

Lists
------
FIXME-- NEEDS TO BE SPECIFIC TO R LISTS
====================
Just as a for loop is a way to do operations many times, a list is a way to store many values. Unlike NumPy arrays, there are built into the language. We create a list by putting values inside square brackets:

odds = [1, 3, 5, 7]
print 'odds are:', odds
We select individual elements from lists by indexing them:

print 'first and last:', odds[0], odds[-1]
and if we loop over a list, the loop variable is assigned elements one at a time:

for number in odds:
    print number
There is one important difference between lists and strings: we can change the values in a list, but we cannot change the characters in a string. For example:

names = ['Newton', 'Darwing', 'Turing'] # typo in Darwin's name
print 'names is originally:', names
names[1] = 'Darwin' # correct the name
print 'final value of names:', names
works, but:

name = 'Bell'
name[0] = 'b'
does not.

Ch-Ch-Ch-Changes

Data that can be changed is called mutable, while data that cannot be is called immutable. Like strings, numbers are immutable: there's no way to make the number 0 have the value 1 or vice versa (at least, not in Python—there actually are languages that will let people do this, with predictably confusing results). Lists and arrays, on the other hand, are mutable: both can be modified after they have been created.

Programs that modify data in place can be harder to understand than ones that don't because readers may have to mentally sum up many lines of code in order to figure out what the value of something actually is. On the other hand, programs that modify data in place instead of creating copies that are almost identical to the original every time they want to make a small change are much more efficient.
There are many ways to change the contents of in lists besides assigning to elements:

odds.append(11)
print 'odds after adding a value:', odds
del odds[0]
print 'odds after removing the first element:', odds
odds.reverse()
print 'odds after reversing:', odds
Challenges

Write a function called total that calculates the sum of the values in a list. (Python has a built-in function called sum that does this for you. Please don't use it for this exercise.)
Processing Multiple Files

We now have almost everything we need to process all our data files. The only thing that's missing is a library with a rather unpleasant name:

import glob
The glob library contains a single function, also called glob, that finds files whose names match a pattern. We provide those patterns as strings: the character * matches zero or more characters, while ? matches any one character. We can use this to get the names of all the IPython Notebooks we have created so far:

print glob.glob('*.ipynb')
['01-numpy.ipynb', '02-func.ipynb', '03-loop.ipynb', '04-cond.ipynb', '05-defensive.ipynb', '06-cmdline.ipynb', 'spatial-intro.ipynb']
or to get the names of all our CSV data files:

print glob.glob('*.csv')
['inflammation-01.csv', 'inflammation-02.csv', 'inflammation-03.csv', 'inflammation-04.csv', 'inflammation-05.csv', 'inflammation-06.csv', 'inflammation-07.csv', 'inflammation-08.csv', 'inflammation-09.csv', 'inflammation-10.csv', 'inflammation-11.csv', 'inflammation-12.csv', 'small-01.csv', 'small-02.csv', 'small-03.csv', 'swc_bc_coords.csv']
As these examples show, glob.glob's result is a list of strings, which means we can loop over it to do something with each filename in turn. In our case, the "something" we want is our analyze function. Let's test it by analyzing the first three files in the list:

filenames = glob.glob('*.csv')
filenames = filenames[0:3]
for f in filenames:
    print f
    analyze(f)
inflammation-01.csv
inflammation-02.csv
inflammation-03.csv
Sure enough, the maxima of these data sets show exactly the same ramp as the first, and their minima show the same staircase structure.

Challenges

Write a function called analyze_all that takes a filename pattern as its sole argument and runs analyze for each file whose name matches the pattern.
Key Points

Use for variable in collection to process the elements of a collection one at a time.
The body of a for loop must be indented.
Use len(thing) to determine the length of something that contains other values.
[value1, value2, value3, ...] creates a list.
Lists are indexed and sliced in the same way as strings and arrays.
Lists are mutable (i.e., their values can be changed in place).
Strings are immutable (i.e., the characters in them cannot be changed).
Use glob.glob(pattern) to create a list of files whose names match a pattern.
Use * in a pattern to match zero or more characters, and ? to match any single character.
Next Steps

We have now solved our original problem: we can analyze any number of data files with a single command. More importantly, we have met two of the most important ideas in programming:

Use functions to make code easier to re-use and easier to understand.
Use lists and arrays to store related values, and loops to repeat operations on them.
We have one more big idea to introduce, and then we will be able to go back and create a heat map like the one we initially used to display our first data set.