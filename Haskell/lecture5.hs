-- homework solution

--data Dir = Up | Down

--step 0 num den _ = (num, den)
--step left 1 den Up = step (left-1) 1 (den+1) Down
--step left num 1 Down = step (left-1) (num+1) 1 Up
--step left num den Up = step (left-1) (num-1) (den+1) Up
--step left num den Down = step (left-1) (num+1) (den-1) Down

--main count = step (count-1) 1 1 Up


-- factorial
fact 0 = 1
fact n = n * fact (n-1)

-- square
squarelist [] = []
squarelist (x:xs) = (x * x) : squarelist xs

-- infcantor
diag n = [swap_if_odd n (k, n+1-k) | k <- [1..n]]
swap_if_odd n (x, y) 
	| odd n = (y, x)
	| otherwise = (x, y)
cantor0 = concat[diag n | n <- [1..]]
cantor x = cantor0 !! (x-1)



