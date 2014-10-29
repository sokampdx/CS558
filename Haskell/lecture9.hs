add2 x = x + 2
mymap f [] = []
mymap f (x:xs) = f x : mymap f xs

mul3 x = x * 3

-- crazy add2 mul3
-- crazy mul3 add2

crazy f g = \x -> if even x then f (g x) else g (f x)

