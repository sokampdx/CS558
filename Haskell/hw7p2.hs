{-
Anthony So (KAM PUI)
CS558 Fall 2014
Homework #7 problem 2

Problem 2
Do in Haskell an adapted version of Problem 1 above. Haskell has no exception, no arrays, and no methods. Therefore, you will code a function that takes a list of integers and returns a union type (see previous lecture) that abstracts both an integer and that no suitable integer exists.

From the command line interpreter call the function with an input for which the function returns an integer and with an input for which the function returns no integer. No explicit I/O is required. The value displayed by the the command line interpreter loop suffices. 

-}

data MayResult a
	= NoResultAllOdd 
	| MinEvenNum a
	deriving (Show, Eq)

minEven :: (Integral a) => [a] -> MayResult a
minEven [] = NoResultAllOdd
minEven (x:xs)
	| odd x = minEven xs
	| otherwise = minEven1 x xs

minEven1 :: (Integral a) => a -> [a] -> MayResult a
minEven1 e [] = MinEvenNum e
minEven1 e (x:xs)
	| (even x) && (x < e) = minEven1 x xs
	| otherwise = minEven1 e xs


-- Test
good = [8, 9, 11, -2, 17, 21, 33]
bad = [3, 1, 11, 27, -59, 63, 15]

{- Interpreter Output

*Main> :l hw7p2.hs 
[1 of 1] Compiling Main             ( hw7p2.hs, interpreted )
Ok, modules loaded: Main.
*Main> minEven good
MinEvenNum (-2)
*Main> minEven bad
NoResultAllOdd

-}


