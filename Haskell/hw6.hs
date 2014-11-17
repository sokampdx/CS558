{-
KAM PUI SO (ANTHONY)
CS 558 Fall 2014
Homework 6 Prob 2
-}

{- Problem 2

Graph Representation:
Adjacency List Adj [(a, [a])] is list of tuple of node A and list of all the nodes that share an edges with node A.

Algorithm:
- start at the end node (e.g. 5) 
- search each element of adjacent list to find a matching node
- if found, look up all the nodes that share an edge with the matching node (e.g. for node 5, [2,3,4]). If not found, look at the next element in the adjacent list.
- if there is no adjacent nodes, check if start node is the same as end node, if so append start node to the front of temporary result. otherwise, return empty list because this is an dead end.
- if there are nodes adjacent to our end node, then for each node in the list of adjacent nodes, check if start node and end node is the same, 
- If so, add start to the beginning of the temporary result. 
- If end node is already in the list of temporary result, then it returns empty list because we circle back to a visited node.
- Otherwise, make the first node from the adjacent list of node as a new end node and find all the path from start to this node. In additional, we need to check the paths for remaining adjacent nodes to the end node.

In short the algorithm build list of list as follow:
- after visited node 5 & found all adjacent nodes.
[[2,5], [3,5], [4,5]]
- after [2,5] branch visited node 2 and found adjacent nodes.
[[1,2,5], [3,2,5], ..]
- [1,2,5] is one of the answer and [3,2,5] continue as
[[1,2,5], [1,3,2,5], [4,3,2,5], ..]
- [1,3,2,5] is one of the answer and [4,3,2,5] continue as
[[1,2,5], [1,3,2,5], [1,4,3,2,5], ..]

-}

data Graph a
	= Adj [(a, [a])]
	deriving (Show, Eq)

-- check if a is a member of [a]
isMember :: (Eq a) => a -> [a] -> Bool
isMember _ [] = False
isMember x (y:ys) 
	| x == y = True
	| otherwise = isMember x ys

-- find all paths from start to end in graph
findpath :: (Eq a) => a -> a -> Graph a -> [[a]]
findpath start end graph = fpath graph graph start end []

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


-- Test --
-- problem 2 example
g1 = Adj [(1, [2,3,4]), (2, [1,3,5]), (3, [1,2,4,5]), (4, [1,3,5]), (5, [2,3,4])]

-- additional examples
g2 = Adj []
g3 = Adj [(1, []), (2, []), (3, []), (4, []), (5, [])]
g4 = Adj [(1, [2,3,4]), (2, [1,3]), (3, [1,2,4]), (4, [1,3,5]), (5, [4])]


