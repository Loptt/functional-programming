module Challenge03 where

data Matrix = Matrix [[Int]] deriving Show

transposeAux :: [[Int]] -> [[Int]]
transposeAux ([]:_)  = []
transposeAux m = (map head m):(transposeAux (map tail m))

transpose :: Matrix -> Matrix
transpose (Matrix m) = Matrix (transposeAux m)

countNumbers :: [Int] -> Int -> Int
countNumbers [] _ = 0
countNumbers (x:xs) n = if x == n
    then 1 + (countNumbers xs n)
    else countNumbers xs n

getOccurrences :: [Int] -> [(Int, Int)]
getOccurrences [] = []
getOccurrences x = map (\y -> (y, (countNumbers x y))) x

getMaxAux :: [(Int, Int)] -> (Int, Int) -> Int
getMaxAux [] y = fst y
getMaxAux (x:xs) y = if (snd x) > (snd y) 
    then getMaxAux xs x
    else getMaxAux xs y  

getMax :: [(Int, Int)]  -> Int
getMax (x:xs) = getMaxAux xs x

mode :: [Int] -> Int
mode x = getMax (getOccurrences x)

data Set = Set [Int] deriving Show

exist :: Int -> [Int] -> Bool
exist _ [] = False
exist n (x:rest) = if n == x
    then True
    else exist n rest

toSetAux :: [Int] -> [Int]
toSetAux [] = []
toSetAux (x:rest) = if exist x rest
    then toSetAux rest
    else x:(toSetAux rest)

toSet :: [Int] -> Set
toSet x = Set (toSetAux x) 

add :: Set -> Int -> Set
add (Set x) n = toSet (n:x)

removeAux :: [Int] -> Int -> [Int]
removeAux [] _ = []
removeAux (x : xs) n
    | x == n = removeAux xs n
    | otherwise = x : (removeAux xs n)

remove :: Set -> Int -> Set
remove (Set x) n = Set (removeAux x n)

union :: Set -> Set -> Set
union (Set x) (Set y) = toSet (x ++ y)

intersectionAux :: [Int] -> [Int] -> [Int]
intersectionAux [] _ = []
intersectionAux (x:xs) y = if exist x y
    then x:(intersectionAux xs y)
    else intersectionAux xs y

intersection :: Set -> Set -> Set
intersection (Set x) (Set y) = toSet (intersectionAux x y)

halves :: [t] -> ([t], [t])
halves [] = ([], [])
halves x = (take (length x `div` 2) x, drop (length x `div` 2) x) 

merge :: [Int] -> [Int] -> [Int]
merge [] [] = []
merge [] x = x
merge x [] = x
merge (x:xs) (y:ys) = if x < y
    then x:(merge xs (y:ys))
    else y:(merge (x:xs) ys)

mergesort :: [Int] -> [Int]
mergesort [] = []
mergesort [x] = [x]
mergesort x = merge (mergesort (fst (halves x))) (mergesort (snd (halves x)))