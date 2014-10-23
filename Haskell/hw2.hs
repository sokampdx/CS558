-- KAM PUI SO (ANTHONY)
-- CS 558 Fall 2014
-- Homework 2 Part 2

-- triangular number (sum of 1 to n)
tri n
	| n <= 0 = 0
	| otherwise = quot ((n + 1) * n)  2

-- find which diagonal is in
diag x y 
	| tri y >= x = y
	| otherwise = diag x (y + 1)

-- find which diagonal is in
level x
	| x <= 0 = 0
	| otherwise = diag x 1

-- calculate denominator and numinator depend on level
value_a x = (tri (level x)) - x + 1
value_b x = (level x) + 1 - (value_a x)

-- check if the level is even
even_level x = mod (level x) 2

-- return the num and den of the term x as a list
cantor x
	| x <= 0 = []
	| even_level x == 0 = (value_b x):(value_a x):[]
	| otherwise = (value_a x):(value_b x):[]

