invlist [] = 0
invlist (x:xs) = invelem x xs = invlist xs
invelem _ [] = 0
invelem x (y:ys)
	| x <= y = invelem x ys
	| otherwise = 1 + invelem x ys



