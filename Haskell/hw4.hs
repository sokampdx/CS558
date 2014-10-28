-- KAM PUI SO (ANTHONY)
-- CS558 Fall 2014
-- Homework 4

-- Problem 1 : define the abstract syntax
data Oper 
	= Add | Sub | Mul | Div | Mod
	| Equ | NEq | LsT | LsE | GrT | GrE 
	deriving Show

data Expression
	= Number Int
	| Variable String
	| Binary Expression Oper Expression
	deriving Show

data Statement
	= Assignment Expression Expression
	| Compound [Statement]
	| If Expression Statement Statement
	| While Expression Statement
	deriving Show


-- Problem 2a : Factorial
factorial :: Statement
factorial = Compound [stmt1, stmt2, stmt3]
stmt1 = Assignment (Variable "n") (Number 7)
stmt2 = Assignment (Variable "fact") (Number 1)
stmt3 = While expr1 stmt4
expr1 = Binary (Variable "n") GrT (Number 1)
stmt4 = Compound [stmt5, stmt6]
stmt5 = Assignment (Variable "fact") (Binary (Variable "fact") Mul (Variable "n"))
stmt6 = Assignment (Variable "n") (Binary (Variable "n") Sub (Number 1))

-- Problem 2b : Collatz Sequence (Reference Project Euler Problem 14)
collatz :: Statement
collatz = Compound [stmta, stmtb, stmtc]
stmta = Assignment (Variable "num") (Number 13)
stmtb = Assignment (Variable "terms") (Number 1)
stmtc = While expra stmtd
expra = Binary (Variable "num") GrT (Number 1)
stmtd = Compound [stmte, stmtf]
stmte = If exprb stmtg stmth
stmtf = Assignment (Variable "terms") (Binary (Variable "terms") Add (Number 1))
exprb = Binary (Binary (Variable "num") Mod (Number 2)) Equ (Number 0) 
stmtg = Assignment (Variable "num") (Binary (Variable "num") Div (Number 2))
stmth = Assignment (Variable "num") (Binary exprc Add (Number 1))
exprc = Binary (Variable "num") Mul (Number 3)


-- Problem 3 : Interpreter
environ :: [(String, Int)]
environ = []

value :: Expression -> [(String, Int)] -> Int
value (Number x) _ = x
value (Variable name) [] = error "Variable not define"
value (Variable name) ((n, v):remain)
	= if name == n then v else value (Variable name) remain
value (Binary e1 op e2) env = cal op (value e1 env) (value e2 env)
  where cal Add v1 v2 = v1 + v2
        cal Sub v1 v2 = v1 - v2
        cal Mul v1 v2 = v1 * v2
        cal Div v1 v2 | v2 /= 0 = div v1 v2
                      | otherwise = error "Divided by 0"
        cal Mod v1 v2 | v2 /= 0 = mod v1 v2
                      | otherwise = error "Divided by 0"
        cal Equ v1 v2 | v1 == v2 = 1
                      | otherwise = 0
        cal NEq v1 v2 | v1 /= v2 = 1
                      | otherwise = 0
        cal LsT v1 v2 | v1 < v2 = 1
                      | otherwise = 0
        cal LsE v1 v2 | v1 <= v2 = 1
                      | otherwise = 0
        cal GrT v1 v2 | v1 > v2 = 1
                      | otherwise = 0
        cal GrE v1 v2 | v1 >= v2 = 1
                      | otherwise = 0



--execute :: Statement -> [([Char], Int)] -> [([Char], Int)]
--execute (Assignment (Variable name) e2) ((n, v):remain)
--execute (Compound s) env = foldr (`execute` env) s 


 

-- test samples
envtest :: [(String, Int)]
envtest = [("abc", 7), ("test",1)]

-- expression test
ex1 = Number 4
ex2 = Binary (Number 7) Add ex1
ex3 = Variable "abc"
ex4 = Binary (Variable "test") GrT ex2
ex5 = Binary ex1 Equ ex2
ex6 = Binary ex4 LsE ex5
-- [4, 11, 1, 0, 0, 1]
testcase1 = [ex1, ex2, ex3, ex4, ex5, ex6]

-- statement test
st1 = Assignment (Variable "x") ex1
st2 = Compound [st1, (Assignment (Variable "y") ex2), (While ex5 st1)]
st3 = If ex6 st1 st2
st4 = While ex5 st1
st5 = Compound [st1, st2, st3, st4]
testcase2 = [st1, st2, st3, st4, st5]

-- test = map (map value (testcase)) environ
testexp = map (`value` envtest) testcase1
-- teststm = map (`execute` environ) testcase2

diffl :: (Num a) => [a] -> [a]
diffl xs = scanl (-) 0 xs

diffr :: (Num a) => [a] -> [a]
diffr xs = scanr (-) 0 xs

aenv :: [(String, Int)]
aenv = [("a", 0), ("b", 1), ("c", 2)]
assign :: String -> Int -> [(String, Int)] -> [(String, Int)]
assign name val [] = [(name, val)]
assign name val ((n,v):xs) 
    | name == n = ((n,val):xs)
    | otherwise = (n,v):(assign name val xs)






