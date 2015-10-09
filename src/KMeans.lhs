Simple k-means implementation. Not very strongly typed, but mainly to experiment
with things.

> module KMeans where

> type Point = [Int]

Divide up a list of Points based on their distance from some prototypes

 cluster :: [Point] -> [Point] -> [[Point]]
 cluster ps cs = addToClusters cs (clusterInit [] cs) ps

> clusterInit :: [(Point, [Point])] -> [Point] -> [(Point, [Point])]
> clusterInit = foldl (\xs c -> (c, []) : xs)

> distance xs ys = sum . map (\x -> x * x) $ diffs xs ys
>   where diffs    []     ys  = []
>         diffs    xs     []  = []
>         diffs (x:xs) (y:ys) = (x - y) : diffs xs ys

> closestCluster :: Point -> [Point] -> Int
> closestCluster p (c:cs) = minOf (0, distance p c) 1 cs
>   where minOf (i, d) n []     = i
>         minOf (i, d) n (x:xs) = let d' = distance p x
>                                  in minOf (if d' < d then (n, d') else (i, d))
>                                           (n+1)
>                                           xs

 addToClusters :: [Point] -> [(Point, [Point])] -> [(Point, [Point])]
 addToClusters []        cs  = cs
 addToClusters (m:ms) (c:cs) =
