#! /usr/bin/env python
# slicing is defined as taking some amount of data from the whole input by using 3 parameters named [start:stop:step]. we can slice lists, arrays, touples, strings, etc....
#Example for slicing a string

str1 = "hello World"
str2 = slice(0,6)
print str1[str2]
list1 = [1,2,3,4,5,6,7,8]
list2 = slice(2,6)
print list1[list2]
