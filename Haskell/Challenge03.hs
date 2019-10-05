module Challenge03 where

data Matrix = Matrix [[Int]] deriving Show

transposeAux :: [[Int]] -> [[Int]]
transposeAux ([]:_)  = []
transposeAux m = (map head m):(transposeAux (map tail m))

transpose :: Matrix -> Matrix
transpose (Matrix m) = Matrix (transposeAux m)

-- mode :: [Int] -> Int

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

add :: Set -> Set
add (Set x) n = Set (toSet n:x)

