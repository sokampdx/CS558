{-
Anthony So (Kam Pui)
CS558 Fall 2014
Homework 8 problem 4

Problem 2
Early in the course you coded a small interpreter. A component of the interpreter was a simple data type to hold the environment and a couple of functions or predicates to manipulate it.

———————
Part 1:
———————
Code, in Haskell or Prolog, a data type structured as a binary search tree to hold the environment of the small interpreter. Provide functions or predicates to store and retrieve the binding of a variable.
-}

-- define binary tree structure for update and lookup for environment
data BinTree a
	= Leaf
	| Node (BinTree a) a (BinTree a) 
	deriving Show

data Env
	= Env String Int
	deriving Show

updateEnv :: Env -> BinTree Env -> BinTree Env
updateEnv e Leaf = Node Leaf e Leaf
updateEnv (Env s1 x1) (Node left (Env s x) right)
	| s1 < s = Node (updateEnv (Env s1 x1) left) (Env s x) right
	| s1 > s = Node left (Env s x) (updateEnv (Env s1 x1) right)
	| otherwise = Node left (Env s x1) right

lookupEnv :: String -> BinTree Env -> Int
lookupEnv _ Leaf = error "Variable not define"
lookupEnv s1 (Node left (Env s x) right)
	| s1 < s = lookupEnv s1 left
	| s1 > s = lookupEnv s1 right
	| otherwise = x


-- original interpreter from hw4 with binary tree environment
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


-- value (lookup environment for variable)
value :: Expression -> BinTree Env -> Int
value (Variable name) env = lookupEnv name env
value (Number x) _ = x
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

-- assignment (change environment)
assign :: String -> Int -> BinTree Env -> BinTree Env
assign name val env = updateEnv (Env name val) env


-- execute statement environment
execute :: Statement -> BinTree Env -> BinTree Env
execute (Assignment (Variable name) e2) env = assign name (value e2 env) env
execute (Compound (s:[])) env = execute s env
execute (Compound (s:r)) env = execute (Compound r) (execute s env)
execute (If e1 st sf) env
	| (value e1 env) == 1 = execute st env
	| otherwise = execute sf env
execute (While e1 s) env
	| (value e1 env) == 1 = execute (While e1 s) (execute s env) 
	| otherwise = env
execute _ env = env


-- beginning environment
environ :: BinTree Env
environ = Leaf


-- run program command with empty environment
run :: Statement -> BinTree Env
run program = execute program environ

{-
———————
Part 2:
———————
Discuss how you would extend your code to include the following situations. You do not have to code anything, simply write in English a couple of paragraphs.

-Your environment should gracefully handle a request to retrieve an uninitialized binding,

==> Answer:
I feel that allowing retrieval of any uninitialized binding seems incorrect since the compiler can not guess the usage of the variable from the user. However, to be able to gracefully handle such request, we can document a list of default value for uninitialized binding for each type of value. Here is some example:
Bool ::  False
Int :: 0
Char :: ''
Float :: 0.0

Another way is to use a data type like Maybe that give the value of the variable or some indication of the variable is uninitialized. We will need to redefine the functions that uses the data type to return either the value or an uninitialized message depend on the initialization of the arguments.

data Maybe a
	= Just a
	| Uninitialized

for example, value type definition could changed to
value :: Expression -> BinTree Env -> Maybe Int
where Env definition also changed
data Env = Env String (Maybe Int)
or something similar to this idea.

-Your environment should handle nested scopes. 

==> Answer:
We can define a Stack for the environment with nested scopes by having an array of binary tree. Similar to this:

data Stack a
	= [BinTree a]
	deriving Show

Each time we run a procedure/program, we create a new environment binary tree at the beginning of the procedure and push it onto the stack like this: 

pushEnv :: Stack Env -> Stack Env 
pushEnv [] = [Leaf]
pushEnv stack = (Leaf):stack

At the end of the procedure, we pop the top binary tree off of the stack.
popEnv :: Stack Env -> Stack Env
popEnv (x:xs) = xs

When we update/lookup, we update/lookup starting at the binary tree environment on the top of the stack first. If we can't find the variable name, we look at the next binary tree in the array and so on until we find it, we give an error or we define the variable to the default value.

-}
