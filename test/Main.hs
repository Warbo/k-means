module Main where

import KMeans
import           Test.Tasty             (defaultMain, testGroup, localOption)
import           Test.Tasty.QuickCheck

main = defaultMain tests

tests = testGroup "All tests" [
    testProperty "clusterInit makes enough clusters" clusterInitLength
  , testProperty "Closest finds copies"              closestToSelf
  , testProperty "Closest is closest"                closestIsClosest
  ]

clusterInitLength cs = length (clusterInit [] cs) == length cs

closestToSelf p ps = closestCluster p (p:ps) == 0

closestIsClosest p c cs = let clusters = c:cs
                              n        = closestCluster p clusters
                              closest  = clusters !! n
                              d        = distance p closest
                              ds       = map (distance p) clusters
                           in all (>= d) ds
