module EX01 where

data Tree = Tree Int Tree Tree | E deriving Show

sumTree :: Tree -> Int
sumTree E = 0
sumTree (Tree n left right) = n + (sumTree left) + (sumTree right)

insert :: ([Char], Int) -> [([Char], Int)] -> [([Char], Int)]
insert x [] = [x]
insert (x1, x2) ((y1,y2):ys) = if x2 < y2 
    then (x1, x2):(y1, y2):ys
    else (y1, y2):(insert (x1, x2) ys)

sort :: [([Char], Int)] -> [([Char], Int)]
sort [] = []
sort (x:xs) = insert x (sort xs)

getRest :: [Char] -> Int -> [Char]
getRest x 0 = x
getRest (x:xs) n = getRest xs (n-1)

getFirst :: [Char] -> Int -> [Char]
getFirst x 0 = []
getFirst (x:xs) n = x:(getFirst xs (n-1))

crossover :: [Char] -> [Char] -> Int -> ([Char], [Char])
crossover a b k = (((getFirst a k)++(getRest b k)), ((getFirst b k)++(getRest a k)))

data Color = Red | Black deriving Show
data Suit = Diamonds | Clubs | Hearts | Spades deriving Show
data Rank = Joker | Queen | King | Ace deriving Show
data Card = Card (Rank, Suit) deriving Show

getValue :: Card -> Int
getValue (Card (Joker, s)) = 11
getValue (Card (Queen, s)) = 12
getValue (Card (King, s)) = 13
getValue (Card (Ace, s)) = 1

getColor :: Card -> Color
getColor (Card (r, Diamonds)) = Red
getColor (Card (r, Hearts)) = Red
getColor (Card (r, Clubs)) = Black
getColor (Card (r, Spades)) = Black

enigmaA :: [Int] -> [Int] 
enigmaA x = (\x y -> map y x) x (\x -> x + 1)

enigmaB :: [Double] -> Double -> [(Bool , Bool)] 
enigmaB x y = zip (map (> y) x) (map (< y) x)

enigmaC :: [Int] -> Int -> Int 
enigmaC [] x = x 
enigmaC (x:xs) y = x * (enigmaC xs y)

enigmaD :: Char -> [(Char , Char)] -> [Char] 
enigmaD x [] = [x] 
enigmaD x ((a, b):c) = a:b:(enigmaD b c)