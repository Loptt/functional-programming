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

-- 1
multiply :: [[Int]] -> [[Int]] -> [[Int]]
multiply [] _ = []
multiply (x:xs) y = (multiplyAux x (transpose y)):(multiply xs y)

-- 2
getAverageHeights :: [([Char], Double)] -> [([Char], Double)]
getAverageHeights [] = [("Male", 0), ("Female", 0)]
getAverageHeights t = 
    let males = (filter (\(x, y) -> x == "Male") t)
        females = (filter (\(x, y) -> x == "Female") t)
    in [
            ("Male", ((foldl (\a (x1, x2) -> a + x2) 0 males) / (fromIntegral (length males)))),
            ("Female", ((foldl (\a (x1, x2) -> a + x2) 0 females) / (fromIntegral (length females))))
        ]
-- 3
getStudentsBelow :: [([Char], Double)] -> Double -> [([Char], Double)]
getStudentsBelow [] _ = []
getStudentsBelow x n = (filter (\(x, y) -> y < n) x )

data Node = Node Int [Int]

-- Graph implementation:
-- Adjacency list:
-- [[1,2] [3,1] [1,2,3]]

getLargestDegree

getLargestDegree :: [Node] -> Node
getLargestDegree [] = Node 0 []
getLargestDegree g = a
