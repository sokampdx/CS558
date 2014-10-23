fact n =
	if n == 0
	then 1
	else n * fact (n-1)

gcd1 u v =
	if v == 0
	then u
	else gcd1 v (mod u v)

square x = x * x

squarelist lis =
	if (null lis) then lis
	else square (head lis):
		squarelist (tail lis)


fibolist = f 0 1
f x y = x : f y (x + y)


data Bintree 
	= Leaf 
	| Branch Bintree Int Bintree 
	deriving Show

-- left (Branch l x r) = l
mytree = Branch Leaf 6 (Branch Leaf 8 Leaf)

isin _ Leaf = False

--isin n (Branch l x r) = 
--	if n < x then isin n l else
--	if n > x then isin n r else
--	True

isin n (Branch l x r)
	| n < x = isin n l
	| n > x = isin n r
	| otherwise = True

	

--diag x y =
--	if (tri y >= x)
--	then y
--	else diag x (y+1)

--tri n = 
--	if n == 0
--	then 0
--	else n + tri (n - 1)

--tri n
--	| n <= 0 = 0
--	| otherwise = n + tri (n - 1)


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

test x = (x+1):(x+2):[]



