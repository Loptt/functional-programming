module CW05 where

myLast :: [t] -> t
myLast [] = error "Empty List"
myLast [x] = x
myLast (x:y) = last y

halves :: [t] -> ([t], [t])
halves [] = ([], [])
halves x = (take (length x `div` 2) x, drop (length x `div` 2) x) 

data Student = Student Integer [Char] Integer deriving Show

findSum :: [Student] -> Integer
findSum [] = 0
findSum ((Student _ _ g): y) = g + findSum y

data Coord = Coord Double Double deriving Show

sumCoordInt :: Coord -> Integer -> Coord
sunCoordInt c 0 = Coord c
sumCoordInt (Coord x y) n = Coord (x + (fromIntegral n)) (y + (fromIntegral n))