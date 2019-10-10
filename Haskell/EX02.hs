module EX02 where

removeAux :: Int -> [t] -> [t]
removeAux _ [] = []
removeAux 0 _ = []
removeAux n (x:xs) = x:(removeAux (n - 1) xs)

remove :: Int -> [t] -> [t]
remove _ [] = []
remove n x = removeAux ((length x) - n) x

quickSort :: [Int] -> [Int]
quickSort [] = []
quickSort [x] = [x]
quickSort x = (quickSort (filter (< head x) x)) ++ [head x] ++ (quickSort (filter (> head x) x))

data Complex = Complex Int Int deriving Show

add :: Complex -> Complex -> Complex
add (Complex r1 i1) (Complex r2 i2) = Complex (r1+r2) (i1+i2)

multiply :: Complex -> Int -> Complex
multiply (Complex r i) n = Complex (r*n) i

getReal :: Complex -> Int
getReal (Complex r i) = r

getImaginary :: Complex -> Int
getImaginary (Complex r i) = i

enigmaA :: [t] -> Int -> [(t, Int)] 
enigmaA [] x = [] 
enigmaA (x:xs) y = if even (length (xs)) 
    then (x, length (x:xs) * y) : enigmaA (xs) y 
    else enigmaA xs y

enigmaB :: [Int] -> Int 
enigmaB [] = 0 
enigmaB (x:y) = x * 2

enigmaC :: [Int] -> [Int] -> Int 
enigmaC v w = sum (filter (>0) (map (\(x, y) -> x + y) (zip v w)))
