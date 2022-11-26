#!/usr/bin/env runghc

{-# LANGUAGE LambdaCase #-}
{-# OPTIONS_GHC -Wall -Werror #-}

import Control.Monad (forM_)
import Crypto.Hash (Digest, SHA256 (..), hashFinalize, hashInit, hashUpdates)
import qualified Data.ByteArray as BA
import qualified Data.ByteString.Char8 as C8
import Data.Function (on, (&))
import Data.List (sort, sortBy)
import System.Environment (getArgs)
import System.Random (RandomGen, mkStdGen, randoms)

sortFst :: Ord a => [(a, b)] -> [(a, b)]
sortFst = sortBy (compare `on` fst)

randomize :: RandomGen g => [a] -> g -> [a]
randomize xs g =
  zip (randoms g :: [Int]) xs
    & sortFst
    & map snd

distribute :: RandomGen g => [a] -> g -> [(a, a)]
distribute as g =
  let rs = randomize as g
   in zip rs (drop 1 $ cycle rs)

printDistribution :: [(String, String)] -> IO ()
printDistribution = mapM_ $ \(from, to) ->
  putStrLn $ from <> " → " <> to

mkSeed :: [String] -> Int
mkSeed = cutInt . hashStrings
  where
    cutInt = foldl shift 0 . take 4 . BA.unpack
    shift accum curr = (accum * 256) + fromIntegral curr
    hashStrings :: [String] -> Digest SHA256
    hashStrings = hashFinalize . hashUpdates hashInit . map C8.pack

main :: IO ()
main = do
  inputs <- sort . lines <$> getContents
  getArgs >>= \case
    [] -> print "usage: christmas.hs <year> [...year]"
    years -> forM_ years $ \year -> do
      let randG = mkStdGen $ mkSeed (year : inputs)
          result = sortFst $ distribute inputs randG
      putStrLn $ "Juletrekning for " <> year
      printDistribution result
      putStrLn ""
