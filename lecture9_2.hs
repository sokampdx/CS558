-- Problem 1

data Entity 
	= Employee String
	| Group [Entity] 
	deriving Show

-- recursive and union

count_e (Employee _) = 1
count_e (Group g) = count_l g

count_l [] = 0
count_l (x:xs) = count_e x + count_l xs


-- Problem 2
{-
1. 9, 4
2. 10, 5
3. 9, 5

-}


-- Problem 3
twice f x = f (f x)
twice :: a -> b -> c
twice :: (a1 -> a2) -> b -> c
twice :: (b -> b) -> b -> b

mpair f g (x, y) = (f x, g y)
mpair :: a -> b -> c -> d
mpair :: a -> b -> (c1, c2) -> (d1, d2)
mpair :: (a1 -> a2) -> (b1 -> b2) -> (c1, c2) -> (d1, d2)
mpair :: (c1 -> d1) -> (d2 -> b2) -> (c1, c2) -> (d1, d2)

-- Problem 4

access point to the stack frame of the nested
control point to the stack frame of the caller

->main
->f
local = 2
control -> main (main call f)
access -> n/a
->g
control -> f (f call g)
access -> f (f nested g)
->f
control -> g
local = 1
acess -> n/a
->g

->f
local = 0


-- Problem 5

class badcylinder extend exception

int failcount = 0;
while (true) {
  try {
    controller(cyl_num);
	// do whatever and return
  } catch ( controller_exception e) {
	failcount++;
    if (failcount >= n)
      throw e;
		
  }
}


-- Problem 6
1. structure and name
2. 
3. lazy
4. static, local, dynamic
