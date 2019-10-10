module EX03 where

myLambda = (\x y -> if x > y then x - y else x + y)

minMaxAux :: [Int] -> Int -> Int -> (Int, Int)
minMaxAux [] min max = (min, max)
minMaxAux (x:xs) min max = if x < min
    then minMaxAux xs x max
    else if x > max
        then minMaxAux xs min x
        else minMaxAux xs min max

minMax :: [Int] -> (Int, Int)
minMax [] = (0,0)
minMax x = minMaxAux x (head x) (head x)

data RGB = RGB (Int, Int, Int) deriving Show

getR :: RGB -> Int
getR (RGB (red, green, blue)) = red

getG :: RGB -> Int
getG (RGB (red, green, blue)) = green

getB :: RGB -> Int
getB (RGB (red, green, blue)) = blue

getMaxComponent :: RGB -> ([Char], Int)
getMaxComponent (RGB (red, green, blue)) = if red > green
    then if red > blue
        then ("Red", red)
        else ("Blue", blue)
    else if green > blue
        then ("Green", green)
        else ("Blue", blue)

combine :: RGB -> RGB -> RGB
combine (RGB (red1, green1, blue1)) (RGB (red2, green2, blue2)) = RGB (((red1+red2) `div` 2), ((green1+green2) `div` 2),((blue1+blue2) `div` 2))

enigmaA :: Int -> Int -> [ Int ]
enigmaA 0 _ = []
enigmaA _ 0 = []
enigmaA n m = take ( m - n ) [ n ..]

enigmaB :: ( Int , Int , [ Int ]) -> [ Int ]
enigmaB (x , 0 , ( y : z ) ) = [x , 0 , y ]
enigmaB (x , y , []) = [y , x ]
enigmaB (x , y , z ) = filter ( > x * y ) z

enigmaC :: [ t ] -> t
enigmaC [] = error " Empty list ."
enigmaC ( x : y : z ) = y
