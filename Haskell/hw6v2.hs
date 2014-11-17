
data Graph a
	= Graph [a] [(a,a)]
	| Adj [(a, [a])]
	deriving (Show, Eq)

isMember :: (Eq a) => a -> [a] -> Bool
isMember _ [] = False
isMember x (y:ys) 
	| x == y = True
	| otherwise = isMember x ys

adjacent :: (Eq a) => a -> a -> Graph a -> Bool
adjacent _ _ (Graph _ []) = False
adjacent x y (Graph _ es)
	= (isMember (x,y) es) || (isMember (y,x) es)
adjacent _ _ (Adj []) = False
adjacent x y (Adj ((n,es):lst))
	| (x == n) && (isMember y es) = True
	| otherwise = adjacent x y (Adj lst)


{-
findpath :: (Eq a) => Graph a -> a -> a -> [[a]]
findpath graph start end = fpath graph start [end]

fpath :: (Eq a) => Graph a -> a -> [a] -> [[a]]
fpath graph start (n:ns)
	| start == n = [(n:ns)]
	| otherwise = [[]]
-}
findpath :: (Eq a) => a -> a -> Graph a -> [[a]]
findpath start end graph = fpath graph graph start end []

--fpath :: (Eq a) => Graph a -> a -> a -> [a] -> [[a]]
--fpath (Adj ns) start end result = fpathX (Adj ns) start end result [x | (n,es)<-ns, end == n, x<-es]
--fpath graph start end result = fpath1 graph graph start end result

fpath :: (Eq a) => Graph a -> Graph a -> a -> a -> [a] -> [[a]]
fpath _ (Adj []) _ _ _ = []
fpath graph (Adj ((n,es):ns)) start end result
	| end == n = fpathX graph start end result es
	| otherwise = fpath graph (Adj ns) start end result

fpathX :: (Eq a) => Graph a -> a -> a -> [a] -> [a] -> [[a]]
fpathX graph start end result []
	| start == end = [start:result]
	| otherwise = []
fpathX graph start end result (e:es)
	| start == end = [start:result]
	| (isMember end result) == True = []
	| otherwise = (fpath graph graph start e (end:result)) ++ (fpathX graph start end result es)


{-
fpath :: (Eq a) => Graph a -> a -> a -> [a] -> [[a]]
fpath (Adj ns) start end result = fpathX (Adj ns) start end result [x | (n,es)<-ns, start == n, x<-es]

fpathX :: (Eq a) => Graph a -> a -> a -> [a] -> [a] -> [[a]]
fpathX graph start end result []
	| start == end = [result ++ [end]]
	| otherwise = []
fpathX graph start end result (n:ns)
	| start == end = [result ++ [end]]
	| (isMember start result) == True = []
	| otherwise = (fpath graph n end (result++[start])) ++ (fpathX graph start end result ns)
-}
 






--  v is not in (n:ns) AND v adjacent to n
--  map e to current result (e1:n:ns)..(e2:n:ns)..
-- call fpath on all of these




fn x y z = x + y + z

test [] [] = []
test [] z = []
test y [] = []
test (y:ys) zs = (test1 y zs):(test ys zs)

test1 zs lst y = [x:(lst) | x <- zs, y < x]      






g1 = Graph [1,2,3,4,5] [(1,2),(1,3),(1,4),(2,3),(2,5),(3,4),(3,5),(4,5)]
g2 = Graph [] []
g3 = Graph [1,2,3,4,5] []

g4 = Adj [(1, [2,3,4]), (2, [1,3,5]), (3, [1,2,4,5]), (4, [1,3,5]), (5, [2,3,4])]
g5 = Adj []
g6 = Adj [(1, []), (2, []), (3, []), (4, []), (5, [])]
g7 = Adj [(1, [2,3,4]), (2, [1,3]), (3, [1,2,4]), (4, [1,3,5]), (5, [4])]


