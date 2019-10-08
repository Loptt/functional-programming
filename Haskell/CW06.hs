
module CW06 where

enigmaE :: [Int] -> Int -> [[Int]]
enigmaE [] z = [z:[]]
enigmaE (x:y) z = [x * 2] : enigmaE y (z+1)
