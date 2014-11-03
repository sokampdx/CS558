-- inversion (miderm)

len [] = 0
len (_:x) = 1 + len x

inorder x = take x [1..]

inversion [] = 0
inversion perm = inverCt perm (inorder (length perm)) 0

inverCt [] [] count = count
inverCt (_:[]) _ count = count
inverCt (p:ps) (x:xs) count
	| p == x = inverCt ps xs count
	| otherwise = inverCt (swap x p ps) (x:xs) (count+1)

swap _ _ [] = []
swap pos elem list = (list!!(elem-(pos+1))):(replace pos elem list)

replace _ _ [] = []
replace pos elem (x:xs)
	| pos /= (elem-1) = x:(replace (pos+1) elem xs)
	| otherwise = elem:xs


