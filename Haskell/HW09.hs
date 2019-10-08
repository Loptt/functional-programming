module HW09 where

transpose :: [[Int]] -> [[Int]]
transpose ([]:_)  = []
transpose m = (map head m):(transpose (map tail m))

rowByRows :: [Int] -> [Int] -> Int
rowByRows [] _ = 0
rowByRows _ [] = 0
rowByRows (x:xs) (y:ys) = x*y + (rowByRows xs ys)

multiplyAux :: [Int] -> [[Int]] -> [Int]
multiplyAux _ [] = []
multiplyAux x (y:ys) = (rowByRows x y):(multiplyAux x ys)

multiply :: [[Int]] -> [[Int]] -> [[Int]]
multiply [] _ = []
multiply (x:xs) y = (multiplyAux x (transpose y)):(multiply xs y)

