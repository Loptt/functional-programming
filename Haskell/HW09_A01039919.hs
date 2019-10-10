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

data Node = Node Int [Int] deriving Show

-- Graph implementation:
-- Adjacency list:
-- [[1,2] [3,1] [1,2,3]]

getLargestAux :: [Node] -> Node -> Node
getLargestAux [] n = n
getLargestAux ((Node a currLst):xs) (Node b maxLst) = if (length currLst) > (length maxLst)
    then getLargestAux xs (Node a currLst)
    else getLargestAux xs (Node b maxLst)

-- 4
getLargestDegree :: [Node] -> Node
getLargestDegree [] = Node 0 []
getLargestDegree g = getLargestAux g (Node 0 [])

processSources :: [Node] -> Node -> Int -> Bool
processSources [] _ _ = False
processSources _ (Node _ []) _ = False
processSources g (Node s lst) d = if (head lst) == d
    then True
    else (dfs g (head lst) d) || (processSources g (Node s (tail lst)) d)

dfs :: [Node] -> Int -> Int -> Bool
dfs [] _ _ = False
dfs g s d = if (length (filter (\(Node x lst) -> x == s) g)) == 0
    then False
    else processSources (filter (\(Node x lst) -> x /= s) g) (head (filter (\(Node x lst) -> x == s) g)) d

-- 5
pathExists :: [Node] -> Int -> Int -> Bool
pathExists [] _ _ = False
pathExists g a b = (dfs g a b) || (dfs g a b)