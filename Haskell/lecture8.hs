-- hw 4
data BinOp = Add | Sub
	deriving Show
-- Int Int (the first Int is data constructor)
-- Change Int Int to Number Int

data Expression 
	= Number Int
	| Composite Expression BinOp Expression
	| Variable String
	deriving Show

environment :: [([Char], Int)]
environment = [("abc", 5),("xyz", 22)]

-- test
ex1 = Number 4
ex2 = Composite (Number 7) Sub ex3
ex3 = Variable "abc"

value :: Expression -> [([Char],Int)] -> Int
value (Number x) _ = x
-- value (Composite e1 Sub e2) = value e1 - value e2

value (Composite e1 op e2) env = aux op (value e1 env) (value e2 env)
	where aux Add v1 v2 = v1 + v2
	      aux Sub v1 v2 = v1 - v2	

value (Variable name) [] = error "Variable not define"
-- find the pair in env that first = name, return second
value (Variable name) ((n, v):r)
	= if name == n then v else value (Variable name) r






