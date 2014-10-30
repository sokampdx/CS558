-- Numbers Properties
--   Find all the factors of a positive integer
factor :: Int -> [Int]
factor 0 = []
factor x = factorOf [1..x] x

factorOf :: [Int] -> Int -> [Int]
factorOf [] _ = []
factorOf (x:xs) y
	| (mod y x) == 0 = x:(factorOf xs y)
	| otherwise = factorOf xs y

--   Find a prime factorization of a positive integer
primeFact :: Int -> [Int]
primeFact 1 = []
primeFact x = checkPrime (factor x)

checkPrime :: [Int] -> [Int]
checkPrime [] = []
checkPrime (x:xs)
	| x == 1 = checkPrime xs
	| otherwise = x:(checkPrime (removeDivisible xs x))

removeDivisible :: [Int] -> Int -> [Int]
removeDivisible [] _ = []
removeDivisible (x:xs) p
	| (mod x p) == 0 = removeDivisible xs p
	| otherwise = x:(removeDivisible xs p)

--   Tell whether a number is prime
isPrime :: Int -> Bool
isPrime 0 = False
isPrime 1 = False
isPrime x = (checkPrime (factor x)) == [x]


-- Construct lists:
--   [1,2,3,...]
constList :: Int -> [Int]
constList x = take x [1..] 

--   [...,3,2,1]
reverseList :: Int -> [Int]
reverseList x = reverse (take x [1..])

--   [0,2,4,6,...]
evenList :: Int -> [Int]
evenList x = take ((div x 2)+1) [0,2..]

--   [1,3,5,7,...]
oddList :: Int -> [Int]
oddList x = take (div (x+1) 2) [1,3..]

--   squares
squareList :: Int -> [Int]
squareList x = map (\x -> x * x) (take x [1..])

--   triangulars
triangleList :: Int -> [Int]
triangleList x = map (\x -> div (x * (x + 1)) 2) (take x [1..])

--   primes
primeList :: Int -> [Int]
primeList x = checkPrime (take x [1..])

--   fibonacci sequence
fib :: Int -> Int
fib 0 = 0
fib 1 = 1 
fib x = fib (x-1) + fib (x-2)

fibList :: Int -> [Int]
fibList 0 = [0]
fibList 1 = [0,1]
fibList x = (fibList (x-1)) ++ [fib x]


-- Manipulate a list:
--   length of a list
--   append two list
--   reverse a list

--   find first element
--   find last element
--   find n-th element

--   remove first element
--   remove given element
--   remove last element
--   remove n-th element
--   insert element at end
--   insert element at n-th position

--   take first n element
--   drop first n element
--   take last n element
--   drop last n element

--   remove all even numbers
--   remove all except even numbers
--   remove every other element

--   rotate left
--   rotate right

--   add together all the numbers
--   average all the numbers

data Tree a 
	= Node a (Tree a)  (Tree a)
	| Leaf
	deriving Show

-- Manipulate a binary search tree
--   build a tree
buildBST :: (Ord a) => a -> (Tree a)
buildBST [] = Leaf
buildBST (x:xs) = buildNode x (buildBST xs)

buildNode :: (Ord a) => a -> (Tree a) -> (Tree a)
buildNode x (Leaf) = Node x Leaf Leaf
buildNode x (Node y left right)
	| x > y = Node y left (buildNode x right)
	| otherwise = Node y (buildNode x left) right

--   count the elements
countBST :: (Tree a) -> Int
countBST Leaf = 0
countBST (Node _ left right) = 1 + countBST left + countBST right

--   count the elements with some property

--   test the membership of an element
memberBST :: (Ord a) => a -> (Tree a) -> Bool
memberBST _ Leaf = False
memberBST x (Node y left right)
	| x == y = True
	| x > y = memberBST x right
	| otherwise = memberBST x left

--   insert an element
insertBST :: (Ord a) => a -> Tree a -> Tree a
insertBST x Leaf = Node x Leaf Leaf
insertBST x (Node y left right)
	| x > y = Node y left (insertBST x right)
	| otherwise = Node y (insertBST x left) right

--   remove an element (harder)
removeBST :: (Ord a) => a -> Tree a -> Tree a
removeBST _ Leaf = Leaf
removeBST x (Node y left right)
	| x == y = removeNode left right
	| x > y = Node y left (removeBST x right)
	| otherwise = Node y (removeBST x left) right 

removeNode :: Tree a -> Tree a -> Tree a
removeNode Leaf Leaf = Leaf
removeNode Leaf tree = tree
removeNode tree Leaf = tree
removeNode tree (Node x left right) = Node x (rotateTree left tree) right

rotateTree :: Tree a -> Tree a -> Tree a
rotateTree Leaf Leaf = Leaf
rotateTree Leaf tree = tree
rotateTree tree Leaf = tree
rotateTree tree (Node x left right) = Node x left (rotateTree tree right)

--   traverse in pre/in/post-order
traverseIn :: Tree a -> [a]
traverseIn Leaf = []
traverseIn (Node x left right) = (traverseIn left) ++ [x] ++ (traverseIn right)

traversePre :: Tree a -> [a]
traversePre Leaf = []
traversePre (Node x left right) = [x] ++ (traversePre left) ++ (traversePre right)

traversePost :: Tree a -> [a]
traversePost Leaf = []
traversePost (Node x left right) = (traversePost left) ++ (traversePost right) ++ [x]

--   sum all the number
sumBST :: Tree Int -> Int
sumBST Leaf = 0
sumBST (Node x left right) = x + (sumBST left) + (sumBST right)

--   average the numbers
aveBST :: Tree Int -> Int
aveBST Leaf = error "empty tree"
aveBST tree = div (sumBST tree) (countBST tree)

-- Manipulate (general) trees
--   build a tree
{- work in progress
buildTree :: [Int] -> Tree
buildTree [] = Leaf
buildTree (x:xs) = buildFT x (buildTree xs)

buildFT :: Int ->Tree -> Tree
buildFT x Leaf = Node x Leaf Leaf
buildFT x (Node y Leaf Leaf) = Node y (Node x Leaf Leaf) Leaf
buildFT x (Node y left Leaf) = Node y left (Node x Leaf Leaf)
buildFT x (Node y left right) = Node y (buildFT x left) right
-}

--   count the elements

--   test the membership of an element

--   traverse in pre/post-order

