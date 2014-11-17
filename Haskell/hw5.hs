-- KAM PUI SO (ANTHONY)
-- CS558 Fall 2014
-- Homework 5 Tokenizer

import Data.Char
-- Problem 1 

data Token a 
	= IDENT a | PLUS | MINUS | MULT | DIV | LPAREN | RPAREN 
	| NUMBER a | EOL | ERROR a
	deriving Show

-- Problem 2

tokenize :: [Char] -> [Token [Char]]
tokenize [] = [EOL] 
tokenize (x:xs) 
	| isSpace x = tokenize xs
	| isDigit x = getDigit [x] xs	
	| otherwise = (getToken x):(tokenize xs) 

getDigit :: [Char] -> [Char] -> [Token [Char]]
getDigit x [] = NUMBER x : [EOL]
getDigit x (y:ys)
	| isDigit(y) = getDigit (x++[y]) ys
	| otherwise = NUMBER x : tokenize (y:ys)

getToken :: Char -> Token [Char]
getToken x
	| x == '(' = LPAREN
	| x == ')' = RPAREN
	| x == '+' = PLUS
	| x == '-' = MINUS
	| x == '*' = MULT
	| x == '/' = DIV
	| isAlpha x = IDENT [x]
	| otherwise = ERROR [x]

-- Problem 3

t1 = "a*(1*a)+a-1"
t2 = "(((a"
t3 = "123 + + 456"
t4 = "x + y - (999)"
t5 = "22-!!"

testcase = [t1, t2, t3, t4, t5]
test = map (tokenize) testcase

{- execution - formatted to show t1-t5 in each line
*Main> :l hw5.hs 
[1 of 1] Compiling Main             ( hw5.hs, interpreted )
Ok, modules loaded: Main.
*Main> test
[[IDENT "a",MULT,LPAREN,NUMBER "1",MULT,IDENT "a",RPAREN,PLUS,IDENT "a",MINUS,NUMBER "1",EOL],
[LPAREN,LPAREN,LPAREN,IDENT "a",EOL],
[NUMBER "123",PLUS,PLUS,NUMBER "456",EOL],
[IDENT "x",PLUS,IDENT "y",MINUS,LPAREN,NUMBER "999",RPAREN,EOL],
[NUMBER "22",MINUS,ERROR "!",ERROR "!",EOL]]
-}


